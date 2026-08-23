import Foundation

public struct User {
    public let id: UUID
    public let handle: String?
    public let joinedAt: Date
}

extension User {
    func copyWith(handle: String?) -> User {
        User(id: self.id, handle: handle, joinedAt: self.joinedAt)
    }
}
