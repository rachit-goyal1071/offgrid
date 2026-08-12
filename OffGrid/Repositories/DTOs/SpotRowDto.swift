import Foundation

struct SpotRowDto: Decodable {
    public let id: UUID
    public let name: String
    public let description: String?
    public let images: [String]
    public let latitude: Double
    public let longitude: Double
    public let upvotes: Int
    public let vibe: String
    public let verified: Bool
    public let createdAt: Date
    public let posterHandle: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, description, images, latitude, longitude, upvotes, vibe, verified
        case createdAt = "created_at"
        case posterHandle = "poster_handle"
    }
}

extension SpotRowDto {
    func toDomain() throws -> Spot {
        guard let vibe = Vibe(rawValue: vibe) else {
            throw DecodingError.dataCorrupted(
                .init(codingPath: [], debugDescription: "Unknown Vibe \(vibe)")
            )
        }
        return Spot(
            id: id,
            name: name,
            coordinates: Coordinates(latitude: latitude, longitude: longitude),
            images: images,
            upvotes: upvotes,
            vibe: vibe,
            description: description,
            verified: verified,
            createdAt: createdAt,
            posterHandle: posterHandle
        )
    }
}
