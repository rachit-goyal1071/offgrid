# Architecture — "Anti-Tourist" App (iOS · SwiftUI · Supabase)

**Owner:** Rachit · **Date:** July 2026 · **Status:** decided, pre-implementation
Companion docs: `design-brief-anti-tourist-app.md`, `Anti-Tourist P0.dc.html` (design source of truth)

No code in this doc by design — it records *what* was decided and *why*, not *how to type it*.

---

## 1. Principles (the constitution)

1. **UI is a function of state.** Nothing updates the screen directly; something changes data and views follow. Every UI bug is first a question of "who owns this data?"
2. **Dependencies point inward.** Views → stores → domain + repositories. The domain core imports nothing (no SwiftUI, no CoreLocation, no Supabase). It is pure, synchronous, and fully unit-tested.
3. **Everything external lives behind a protocol.** Location, network, storage, clock. Test rule of thumb: if you can't control it in a test, wrap it.
4. **One source of truth per fact.** Verification state is computed in exactly one place from check-in records. The profile ring, pin colors, and post-flow interstitial all ask; none of them store a copy.
5. **Views stay dumb.** If logic appears inside a view body, it's in the wrong place.

---

## 2. Layers

| Layer | Contains | Depends on | Knows about UI? | Knows about network? |
|---|---|---|---|---|
| **Presentation** | SwiftUI views + one `@Observable` store per feature (MapStore, PostFlowStore, ProfileStore, SpotDetailStore) | Domain, Data (via protocols) | yes | no |
| **Domain** | Entities, `ResidencyScorer`, `RankingEngine`, verification state machine, vibe definitions | nothing | no | no |
| **Data** | Repository protocols + implementations (Supabase for community data, SwiftData for device-local data) | Domain types | no | yes |
| **System services** | `LocationService` (CLLocationManager wrapper), `PhotoStore` (filesystem + upload pipeline) | Data layer contracts | no | partially |

Stores run on the main actor; all async work uses async/await; the domain stays synchronous.

---

## 3. Decision records

### ADR-1 · Real backend: Supabase
**Decision:** Full Supabase stack — Auth (Sign in with Apple), Postgres + Row Level Security, Storage for photos.
**Why:** Chosen deliberately for learning value (auth flows, query design, RLS) over the lighter "protocol + local-only" option.
**Cost accepted:** every fetch can fail/be slow → explicit load states everywhere; server schema becomes a second codebase to maintain.

### ADR-2 · State: feature stores
**Decision:** One `@Observable` store per feature owning screen state and intents. No global Redux-style tree, no logic in views.
**Why:** Clear ownership, testable, and the pattern Swift shops expect to see.

### ADR-3 · The data split (privacy boundary)
**Decision:**
- **Server (Postgres):** spots, reviews, votes, profiles, per-city verification *results*.
- **Device only (SwiftData):** raw check-in records, post drafts.
- Verification score is computed **on device**; only the outcome (city, state, score) syncs up.
**Why:** Keeps the brand promise — "raw location never leaves the phone" — and is a defensible sync-boundary story.
**Known limitation (accepted):** verification is client-authoritative → spoofable. Future fix: server-side validation via edge function or device attestation (App Attest). Documented, not built.

### ADR-4 · Verification mechanics (recap of product decision)
- Per-city status: `tourist → pending → verified local`.
- Qualify: ~20 in-city app opens in 30 days, ≥6h between counted opens; opens must occur inside the city geofence.
- Decay: no qualifying activity for 14 days → drops back to pending.
- Unverified users **can** post; pins are marked amber/"unverified", rank lower, and retroactively upgrade when the poster qualifies.
- Passive signal: `CLVisit` monitoring (low power) feeding the same store as foreground check-ins.

### ADR-5 · Votes carry context
**Decision:** A vote row stores the voter's local-status *at vote time*. MVP ranking uses a plain sum; the schema is ready for reputation-weighted ranking later (one-function change).

### ADR-6 · Geo queries
**Decision:** Bounding-box filter on lat/lng columns for MVP (single city). Upgrade path: PostGIS + spatial index. Ranking stays **client-side**: fetch nearby candidates, run the pure `RankingEngine` locally (votes + verified boost + time-of-day context).

### ADR-7 · Offline policy
**Decision:** Online-required for community data. Last-fetched results held in memory so the map never blanks. Device-local features (check-ins, drafts) work offline by construction. "Saved spots offline" is a named future milestone, not scope drift.

### ADR-8 · Photos
**Decision:** Compress + resize on device before upload → Supabase Storage bucket → DB stores only the path. Never blobs in the database. Photos display with shot-recency ("2 days ago") as a trust signal.

### ADR-9 · Theming
**Decision:** Semantic token layer mirroring the design file one-to-one (`bg/base`, `text/primary`, `accent/neon`, `accent/ink`, `*/inkOnLight`…). A Theme object resolves tokens per color scheme, injected via environment. **No raw hex and no font names ever appear in a view.** Lime *fills* are theme-invariant; lime *text/strokes* swap to ink variants in light mode (per design file rule, 2a). Two semantic type styles only: display (Space Grotesk 500–600) and body (SF Pro, ≥13pt interactive).

### ADR-10 · Navigation & DI
**Decision:** Routes as an enum driving a `NavigationStack` path — navigation is data, hence testable. Dependency injection via plain environment injection; no DI framework.

### ADR-11 · Testing
**Decision:** Real unit coverage on the domain (scorer, ranking, state machine — all pure). Repository implementations get thin integration tests. Views untested by choice; articulate this trade-off rather than hiding it.

---

## 4. Model / schema sketch

### Server tables (Postgres)

| Table | Key fields | Rules enforced *in the database* |
|---|---|---|
| `profiles` | id (= auth user), handle, joined_at | handle unique; row owned by user (RLS) |
| `city_status` | user_id, city_id, state, score, updated_at | one row per (user, city); only owner writes (RLS) |
| `spots` | id, name, lat, lng, vibe, city_id, poster_id, poster_status_at_post, created_at | only poster updates/deletes own spot (RLS); vibe from fixed set |
| `reviews` | id, spot_id, poster_id, photo_paths[], one_liner (≤90 chars), created_at | only poster edits own review (RLS) |
| `votes` | spot_id, voter_id, value (+1/−1), voter_status_at_vote, created_at | **unique (spot_id, voter_id)** — one vote per user per spot; only owner upserts (RLS) |

RLS is the point: rules hold even if the client misbehaves. Reads are public (browsing needs no account); writes require auth.

### Device-local (SwiftData)

| Store | Fields | Notes |
|---|---|---|
| `CheckInRecord` | city_id, timestamp, source (open / visit) | never uploaded; input to ResidencyScorer |
| `PostDraft` | photos, vibe, one-liner, coordinate | survives app kill mid-post-flow |

### Domain notes
- `Vibe`: fixed enum, 16 cases (design file 2d + 4 Gen Z additions). "everything" is a **filter state**, not a vibe.
- Coordinates stored as two doubles (Apple's coordinate type isn't Codable).
- Verification states: `tourist / pending / verifiedLocal` — per city, never global.

---

## 5. Screen ↔ store ↔ data map

| Screen | Store | Reads | Writes |
|---|---|---|---|
| Map home | MapStore | spots (by bbox + vibe), my saved | — |
| Spot detail | SpotDetailStore | spot, reviews, votes, poster trust | vote (upsert) |
| Post flow | PostFlowStore | my verification state | draft (local) → spot + review + photos (server) |
| Profile | ProfileStore | check-ins (local), city_status | city_status sync |
| Auth sheet | AuthStore | — | Supabase auth session |

Every store exposes an explicit load state: `idle / loading / loaded / failed`. Design implication: skeleton, error, and offline states are required screens (added to designer P1 list).

---

## 6. Milestones

1. **Shell + map, fake data.** Tab bar, hardcoded spots, dark map with pins. *Learn: annotations, camera-as-state.*
2. **Vibe filtering.** Chip selection → derived filtered set → map + sheet list react together. *Learn: derived state.*
3. **Supabase stand-up.** Schema, RLS policies, Sign in with Apple, swap fake repository for real one. *Learn: auth, RLS.*
4. **Post flow.** Draft pattern, photo compression + upload, unverified interstitial. *Learn: storage pipeline.*
5. **Voting + ranking.** Vote upsert, client-side RankingEngine + tests. *Learn: pure-core testing.*
6. **Verification.** LocationService, check-in recording, scorer + state machine + tests, status sync, progress ring. *The centerpiece.*
7. **Surprise me + polish.** Random pick from filtered set, full-screen reveal, haptics, badge celebration.

Rule: UI milestones (1–2) never touch the network; backend enters only at 3.

## 7. Named future work (not scope)

Reputation-weighted ranking (ADR-5) · PostGIS upgrade (ADR-6) · saved-spots offline (ADR-7) · server-side verification validation (ADR-3) · video reviews · quests/badges detail · light-mode ship decision.

## 8. Risks

| Risk | Mitigation |
|---|---|
| Supabase scope balloons | Backend enters at milestone 3 only; schema frozen to §4 for MVP |
| CLVisit hard to demo | Foreground check-ins are the demo path; simulator GPX for movement |
| Cold start (empty map) | Seed hometown with ~30 real pins personally before polish |
| Solo-dev drift | Any new idea lands in §7, not in the current milestone |
