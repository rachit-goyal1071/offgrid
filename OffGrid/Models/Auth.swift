import Foundation

public struct Auth: Codable, Identifiable, Sendable, Equatable {
    
    public let id: UUID
    public let token: String
    public let refreshToken: String
    public let userHandle: String
    
    public init (
        id: UUID,
        token: String,
        refreshToken: String,
        userHandle: String
    ) {
        self.id = id
        self.token = token
        self.refreshToken = refreshToken
        self.userHandle = userHandle
    }
}
