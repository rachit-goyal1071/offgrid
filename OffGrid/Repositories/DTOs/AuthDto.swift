import SwiftUI

struct AuthDto: Codable {
    var uuid: UUID
    var token: String
    var refreshToken: String
    var userHandle: String
    
    enum CodingKeys: String, CodingKey {
        case token, uuid
        case refreshToken = "refresh_token"
        case userHandle = "user_handle"
    }
    
//    @Environment(SessionStore.self) private var session
    private var session: SessionStore = SessionStore()
}

extension AuthDto {
    func toDomain() -> Auth {
        Auth(
            id: uuid,
            token: token,
            refreshToken: refreshToken,
            userHandle: userHandle
        )
    }
}

extension AuthDto {
    func toSessionStore() {
        session.authToken = token
        session.refreshToken = refreshToken
        session.userID = uuid
        session.userHandle = userHandle
        session.isLoggedIn = true
    }
}

extension AuthDto {
    func fromSessionStore() -> Self? {
        if session.isLoggedIn {
            return Self(
                uuid: session.userID!,
                token: session.authToken!,
                refreshToken: session.refreshToken!,
                userHandle: session.userHandle!
            )
        }
        return nil
    }
}
