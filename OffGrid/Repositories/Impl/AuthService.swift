import Supabase

class AuthService {
    private let client: SupabaseClient
    private var auth: AuthClient { client.auth }
    private var sessionStore: SessionStore = SessionStore()
    
    init(client: SupabaseClient) {
        self.client = client
    }
    
    func loginAnonymously(userHandle: String) async throws {
        let session = try await client.auth.signInAnonymously(
            data: [
                "user_handle": .string(userHandle)
            ]
        )
        sessionStore.isLoggedIn = true
        sessionStore.userID = session.user.id
        sessionStore.authToken = session.accessToken
        sessionStore.refreshToken = session.refreshToken
        sessionStore.userHandle = session.user.userMetadata["user_handle"]?.stringValue ?? ""
    }
    
    func logout() {
        sessionStore.clearSession()
    }
}
