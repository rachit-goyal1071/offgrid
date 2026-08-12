import Foundation

public struct Spot: Codable, Identifiable, Sendable, Equatable {
    
    public let id: UUID
    public let name: String
    public let description: String?
    public let images: [String]
    public let coordinates: Coordinates
    public let upvotes: Int
    public let vibe: Vibe
    public let verified: Bool
    public let createdAt: Date
    public let posterHandle: String
    
    public init (
        id: UUID, name: String, coordinates: Coordinates, images: [String], upvotes: Int, vibe: Vibe, description: String?, verified: Bool = false,
        createdAt: Date, posterHandle: String
    ) {
        self.id = id
        self.name = name
        self.coordinates = coordinates
        self.description = description
        self.images = images
        self.upvotes = upvotes
        self.vibe = vibe
        self.verified = verified
        self.createdAt = createdAt
        self.posterHandle = posterHandle
    }
}

public struct Coordinates: Codable, Equatable {
    public var latitude: Double
    public var longitude: Double
}
