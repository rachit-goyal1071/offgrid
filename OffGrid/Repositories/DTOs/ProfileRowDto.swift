import Foundation

struct ProfileDto: Decodable {
    public let id: UUID
    public var handle: String?
    public let joinedAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case handle
        case joinedAt = "joined_at"
    }
}

extension ProfileDto {
    
    func toDomain() -> User {
        return User(
            id: id,
            handle: handle,
            joinedAt: joinedAt
        )
    }
}
