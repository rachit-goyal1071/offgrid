import Foundation

// Real Delhi locations for previews and local development.
// IDs are hardcoded (not UUID()) so a spot keeps the same identity across
// launches — Identifiable/Equatable diffing and any persistence depend on that.
// Coordinates are approximate but land on the right place.
extension Spot {
    public static let samples: [Spot] = [
        Spot(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000001")!,
            name: "Moolchand Parathe Wala",
            coordinates: Coordinates(latitude: 28.5671, longitude: 77.2362),
            images: [
                "https://images.unsplash.com/photo-1613292443284-8d10ef9383fe?q=80&w=800&auto=format&fit=crop",
                "https://images.unsplash.com/photo-1753123643389-6b52b0a03c6b?q=80&w=800&auto=format&fit=crop",
                "https://images.unsplash.com/photo-1785566269467-d63fb8366e28?q=80&w=800&auto=format&fit=crop"
            ],
            upvotes: 342,
            vibe: .threeAmFood,
            description: "Grease-paper parathas at the Moolchand flyover. Busiest well past midnight.",
            verified: true,
            createdAt: Date(timeIntervalSince1970: 0),
            posterHandle: ""
        ),
        Spot(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000002")!,
            name: "Agrasen ki Baoli",
            coordinates: Coordinates(latitude: 28.6271, longitude: 77.2246),
            images: [
                "https://images.unsplash.com/photo-1513014576558-921f00d80b77?q=80&w=800&auto=format&fit=crop",
                "https://images.unsplash.com/photo-1638183209148-e87c0c9bb6f4?q=80&w=800&auto=format&fit=crop",
                "https://images.unsplash.com/photo-1697729442768-b170166665f8?q=80&w=800&auto=format&fit=crop"
            ],
            upvotes: 128,
            vibe: .quietCorners,
            description: "A 14th-century stepwell hidden behind the Barakhamba highrises. Eerily still.",
            verified: true,
            createdAt: Date(timeIntervalSince1970: 0),
            posterHandle: ""
        ),
        Spot(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000003")!,
            name: "Signature Bridge Viewpoint",
            coordinates: Coordinates(latitude: 28.7041, longitude: 77.2318),
            images: [
                "https://images.unsplash.com/photo-1679729264302-32cf0200e42c?q=80&w=800&auto=format&fit=crop",
                "https://images.unsplash.com/photo-1786641657640-c02a666f76e5?q=80&w=800&auto=format&fit=crop"
            ],
            upvotes: 74,
            vibe: .emptySunsets,
            description: "Yamuna going gold under the cable-stayed bridge. Skip the crowded deck, walk north.",
            verified: false,
            createdAt: Date(timeIntervalSince1970: 0),
            posterHandle: ""
        ),
        Spot(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000004")!,
            name: "Kunzum Travel Café",
            coordinates: Coordinates(latitude: 28.5536, longitude: 77.1938),
            images: [
                "https://images.unsplash.com/photo-1760636803574-e90e889f0d4c?q=80&w=800&auto=format&fit=crop",
                "https://images.unsplash.com/photo-1677763914692-a64cd3df92a0?q=80&w=800&auto=format&fit=crop",
                "https://images.unsplash.com/photo-1784638865191-c18c22c4405e?q=80&w=800&auto=format&fit=crop"
            ],
            upvotes: 210,
            vibe: .lofiCafes,
            description: "Pay-as-you-like coffee tucked in Hauz Khas Village. Books, low chatter.",
            verified: true,
            createdAt: Date(timeIntervalSince1970: 0),
            posterHandle: ""
        ),
        Spot(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000005")!,
            name: "Blue Tokai, Champa Gali",
            coordinates: Coordinates(latitude: 28.5246, longitude: 77.2067),
            images: [
                "https://images.unsplash.com/photo-1671960683114-de467fa17c82?q=80&w=800&auto=format&fit=crop",
                "https://images.unsplash.com/photo-1511537190424-bbbab87ac5eb?q=80&w=800&auto=format&fit=crop",
                "https://images.unsplash.com/photo-1755498208443-5d2b6180d934?q=80&w=800&auto=format&fit=crop"
            ],
            upvotes: 156,
            vibe: .lofiCafes,
            description: "Roastery down a fairy-lit alley in Saidulajab. Good for a slow afternoon.",
            verified: false,
            createdAt: Date(timeIntervalSince1970: 0),
            posterHandle: ""
        ),
        Spot(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000006")!,
            name: "Ama Café Rooftop, Majnu-ka-Tila",
            coordinates: Coordinates(latitude: 28.7019, longitude: 77.2277),
            images: [
                "https://images.unsplash.com/photo-1775883377676-e57f47af1734?q=80&w=800&auto=format&fit=crop",
                "https://images.unsplash.com/photo-1648387915505-de301c121a7a?q=80&w=800&auto=format&fit=crop",
                "https://images.unsplash.com/photo-1771695175968-1f7a635212df?q=80&w=800&auto=format&fit=crop"
            ],
            upvotes: 89,
            vibe: .hiddenRooftops,
            description: "Climb through the Tibetan colony's lanes to a rooftop over the river.",
            verified: false,
            createdAt: Date(timeIntervalSince1970: 0),
            posterHandle: ""
        ),
        Spot(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000007")!,
            name: "Paranthe Wali Gali",
            coordinates: Coordinates(latitude: 28.6564, longitude: 77.2306),
            images: [
                "https://images.unsplash.com/photo-1662101875545-0b0cb8b7795b?q=80&w=800&auto=format&fit=crop",
                "https://images.unsplash.com/photo-1760262492874-80283261b99c?q=80&w=800&auto=format&fit=crop",
                "https://images.unsplash.com/photo-1747491745650-378d6acfbf8e?q=80&w=800&auto=format&fit=crop"
            ],
            upvotes: 401,
            vibe: .cheapEats,
            description: "Chandni Chowk's fried-paratha alley. Under ₹150 and a hundred years old.",
            verified: true,
            createdAt: Date(timeIntervalSince1970: 0),
            posterHandle: ""
        ),
        Spot(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000008")!,
            name: "Lodhi Garden",
            coordinates: Coordinates(latitude: 28.5933, longitude: 77.2197),
            images: [
                "https://images.unsplash.com/photo-1597040663342-45b6af3d91a5?q=80&w=800&auto=format&fit=crop",
                "https://images.unsplash.com/photo-1715633743194-14db1edb294c?q=80&w=800&auto=format&fit=crop",
                "https://images.unsplash.com/photo-1642595012740-ff3cc4b1164a?q=80&w=800&auto=format&fit=crop"
            ],
            upvotes: 512,
            vibe: .greenEscapes,
            description: "Tombs and old trees between Khan Market and Safdarjung. Best at opening.",
            verified: true,
            createdAt: Date(timeIntervalSince1970: 0),
            posterHandle: ""
        ),
        Spot(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000009")!,
            name: "Sanjay Van",
            coordinates: Coordinates(latitude: 28.5331, longitude: 77.1874),
            images: [
                "https://images.unsplash.com/photo-1505635725851-c2cfe9e29112?q=80&w=800&auto=format&fit=crop",
                "https://images.unsplash.com/photo-1634815365876-8b39cb54186c?q=80&w=800&auto=format&fit=crop",
                "https://images.unsplash.com/photo-1783077384477-91eeffa493d1?q=80&w=800&auto=format&fit=crop"
            ],
            upvotes: 63,
            vibe: .greenEscapes,
            description: "Forest trails behind Mehrauli. Peacocks, ruins, and no traffic sound.",
            verified: false,
            createdAt: Date(timeIntervalSince1970: 0),
            posterHandle: ""
        ),
        Spot(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000010")!,
            name: "India Gate Lawns",
            coordinates: Coordinates(latitude: 28.6129, longitude: 77.2295),
            images: [
                "https://images.unsplash.com/photo-1587474260584-136574528ed5?q=80&w=800&auto=format&fit=crop",
                "https://images.unsplash.com/photo-1705927122615-02dcef3b1465?q=80&w=800&auto=format&fit=crop",
                "https://images.unsplash.com/photo-1705259506430-cf0a734205cf?q=80&w=800&auto=format&fit=crop"
            ],
            upvotes: 297,
            vibe: .midnightWalks,
            description: "Kartavya Path stays alive late. Cold-coffee carts and a long, lit walk.",
            verified: true,
            createdAt: Date(timeIntervalSince1970: 0),
            posterHandle: ""
        ),
        Spot(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000011")!,
            name: "Patel Chest Chai, North Campus",
            coordinates: Coordinates(latitude: 28.6882, longitude: 77.2094),
            images: [
                "https://images.unsplash.com/photo-1625033405953-f20401c7d848?q=80&w=800&auto=format&fit=crop",
                "https://images.unsplash.com/photo-1768757076530-514fa55aed28?q=80&w=800&auto=format&fit=crop",
                "https://images.unsplash.com/photo-1645603281208-9bc805293aba?q=80&w=800&auto=format&fit=crop"
            ],
            upvotes: 47,
            vibe: .streetChai,
            description: "DU institution. Kulhad chai and Maggi between lectures.",
            verified: false,
            createdAt: Date(timeIntervalSince1970: 0),
            posterHandle: ""
        ),
        Spot(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000012")!,
            name: "My Bar Lounge, Paharganj",
            coordinates: Coordinates(latitude: 28.6448, longitude: 77.2121),
            images: [
                "https://images.unsplash.com/photo-1516458464372-eea4ab222b31?q=80&w=800&auto=format&fit=crop",
                "https://images.unsplash.com/photo-1781740500699-6152039cf944?q=80&w=800&auto=format&fit=crop"
            ],
            upvotes: 118,
            vibe: .diveBars,
            description: "Cheap pitchers, loud, backpacker-heavy. Not pretty, that's the point.",
            verified: false,
            createdAt: Date(timeIntervalSince1970: 0),
            posterHandle: ""
        ),
        Spot(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000013")!,
            name: "Ghazipur Phool Mandi",
            coordinates: Coordinates(latitude: 28.6276, longitude: 77.3255),
            images: [
                "https://images.unsplash.com/photo-1699764681875-dd04ce36b1c3?q=80&w=800&auto=format&fit=crop",
                "https://images.unsplash.com/photo-1779518079934-4caceabe0301?q=80&w=800&auto=format&fit=crop",
                "https://images.unsplash.com/photo-1779518088115-9dff01e01920?q=80&w=800&auto=format&fit=crop"
            ],
            upvotes: 91,
            vibe: .morningMarkets,
            description: "Wholesale flower market that peaks around 5 AM. Marigold everywhere.",
            verified: true,
            createdAt: Date(timeIntervalSince1970: 0),
            posterHandle: ""
        ),
        Spot(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000014")!,
            name: "Khan Market",
            coordinates: Coordinates(latitude: 28.6003, longitude: 77.2273),
            images: [
                "https://images.unsplash.com/photo-1590532740179-b7472613c3c4?q=80&w=800&auto=format&fit=crop",
                "https://images.unsplash.com/photo-1757059830253-f28dca7a6604?q=80&w=800&auto=format&fit=crop",
                "https://images.unsplash.com/photo-1619314127001-425147462b3d?q=80&w=800&auto=format&fit=crop"
            ],
            upvotes: 233,
            vibe: .peopleWatching,
            description: "India's priciest retail lane. Sit outside a café and watch the city's who's-who.",
            verified: true,
            createdAt: Date(timeIntervalSince1970: 0),
            posterHandle: ""
        ),
    ]

    /// A single spot for quick previews.
    public static let sample = samples[0]
}
