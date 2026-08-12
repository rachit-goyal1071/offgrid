# OffGrid

**An anti-tourist city discovery app.** Find where a city actually lives — the 3am food, the quiet rooftops, the places locals guard — posted and verified by people who can prove they live there.

iOS · SwiftUI · Supabase · Delhi first.

> Solo project by [Rachit Goyal](https://github.com/rachit-goyal1071), built as a deep dive into native iOS engineering. Not App Store-bound — the goal is architecture done right, documented honestly, every line hand-written.

---

## The idea

Every discovery app converges on the same problem: the moment a place gets popular, it stops being the place. Reviews get gamed, listicles flatten cities into the same ten spots, and "hidden gems" stop being either.

OffGrid's answer is a **trust mechanic instead of a review mechanic**:

- **Locals are verified by presence, not claims.** The app counts qualifying in-city check-ins over time (~20 opens in 30 days, min 6h apart, inside the city geofence). Hit the bar → `verified local`. Go quiet for 14 days → status decays. Verification is per-city; being a Delhi local says nothing about Mumbai.
- **The map wears its trust on its sleeve.** Lime pins = posted by verified locals. Amber = unverified. Anyone can post; unverified spots rank lower and *retroactively upgrade* when their poster earns verification.
- **Privacy is the product's spine:** raw location history never leaves the phone. The device computes the verification score locally; only the outcome (city, state, score) syncs. There is no server-side movement trail to leak.
- **Vibes over categories.** No "restaurants ★4.2". Twelve moods — `3am food`, `dead quiet`, `old delhi`, `sunset spot`… — one tap filters the whole map.
- **Surprise me.** One button, one random spot from your current filter, full-screen reveal. For when choice is the problem.

## Design language

Dark minimal with **one semantic neon**. Lime `#C7F464` is information, never decoration: verified, primary action, active state, my-upvote. Amber = pending. Coral = negative. *If it glows, it means something.*

Typography by role, never by user choice: Space Grotesk for display/chips/buttons, SF Pro for body, IBM Plex Mono for photo timestamps only. Lowercase voice throughout ("surprise me", "tonight's vibe"). Views never see a hex value or a font name — only semantic theme tokens.

---

## Architecture

Full decisions with rationale live in [`OffGrid/architecture-anti-tourist-app.md`](OffGrid/architecture-anti-tourist-app.md) (11 ADRs, schema, milestones). The short version:

```
Views (SwiftUI, dumb)
  └── Stores (@Observable, one per feature, @MainActor)
        └── Domain (pure Swift — no SwiftUI, no network, no CoreLocation imports)
        └── Repositories (protocols; Supabase impl + sample impl, swapped via DI)
```

**Principles the codebase is held to:**

1. **UI is a function of state.** Nothing touches the screen directly; data changes, views follow. Every store exposes explicit `idle / loading / loaded / failed` view-state — skeleton, error, and empty states are designed screens, not afterthoughts.
2. **Store choices, compute consequences.** Only user decisions persist (selected theme, selected vibe); everything derivable (filtered spots, resolved colors) is computed. A `didSet` on derived data is treated as a bug.
3. **Everything external lives behind a protocol** — network, location, storage. If a test can't control it, it gets wrapped.
4. **One source of truth per fact.** Verification state is computed in exactly one place; the profile ring, pin colors, and post-flow interstitial all *ask* — none of them keep a copy.
5. **No ViewModels.** Views decompose into child views + computed properties; a store enters only when data operations and lifecycle arrive. (`@Observable` + SwiftUI environment, no DI framework.)

**Decisions worth reading (ADR highlights):**

- **The privacy boundary (ADR-3):** server gets community data (spots, votes, verification *results*); the device keeps raw check-in records and post drafts (SwiftData). Known, documented limitation: verification is client-authoritative and therefore spoofable — the honest MVP trade-off, with App Attest / edge-function validation named as the future fix.
- **Postgres with Row Level Security (ADR-1, §4):** public reads (browsing needs no account), zero write policies until the post flow ships — the database enforces the rules even against a misbehaving client.
- **Votes carry context (ADR-5):** each vote stores the voter's local-status *at vote time*. MVP ranks by plain sum; reputation-weighted ranking later is a one-function change, not a migration.
- **Ranking stays client-side (ADR-6):** fetch nearby candidates, run a pure, unit-testable `RankingEngine` locally. Bounding-box geo queries for one city; PostGIS named as the upgrade path, not built early.

## Stack

| | |
|---|---|
| UI | SwiftUI, `@Observable` stores, modern MapKit (`MapCameraPosition`, custom `Annotation` pins) |
| Backend | Supabase — Postgres + RLS, Auth (Sign in with Apple), Storage |
| Local | SwiftData (check-in records, drafts) · UserDefaults (theme selection only) |
| Data flow | Repository protocols → snake_case DTOs → domain models; sample + live impls swappable via a DI container + environment injection |
| Concurrency | async/await throughout; stores on the main actor; domain stays synchronous |

## Status

| # | Milestone | State |
|---|---|---|
| 1 | Shell + map — tab bar, dark map, pins from sample data | ✅ |
| 2 | Vibe filtering — chip row → derived filtered set → map + panel react together | ✅ |
| 3 | Supabase stand-up — live schema + RLS, real repository (14 Delhi spots served from Postgres), DI container | 🔨 Sign in with Apple + User model remaining |
| 4 | Post flow — draft pattern, photo compression → Storage upload, unverified interstitial | ⬜ |
| 5 | Voting + ranking — vote upsert, pure `RankingEngine` + unit tests | ⬜ |
| 6 | **Verification** — `CLVisit` monitoring, on-device residency scorer, per-city state machine, progress ring. *The centerpiece.* | ⬜ |
| 7 | Surprise me + polish — haptics, badge celebration | ⬜ |

Rule that keeps it honest: UI milestones never touch the network; the backend entered only at milestone 3.

**Known debts (tracked, deliberate):** M2 shipped with logged bugs (a semantic token misuse on chip text, a placeholder photo violating the no-stock-photos rule, panel hairline alignment) rather than blocking the core loop; `MapStore.load()` lacks an idle-guard so tab revisits refetch; error states drop the underlying error and lack retry. Every debt has a fix milestone. Shipping with *named* debt beats polishing in place.

## Running it

Requires Xcode 26+, iOS 18+ simulator. Open `OffGrid.xcodeproj`, build. The app points at a live Supabase project via its publishable (client-safe, RLS-guarded) key in `Constants.swift`; a sample repository with 14 real Delhi spots is available behind the same protocol if the backend is paused (free tier sleeps after ~a week idle).

## Future work (named, not scope)

Reputation-weighted ranking · PostGIS + spatial index · saved spots offline · server-side verification validation (App Attest) · video reviews · quests & badges · light-mode ship decision.

---

*Design source of truth: `Anti-Tourist P0.dc.html` (Claude Design export). Architecture doc beats memory; design file beats both.*
