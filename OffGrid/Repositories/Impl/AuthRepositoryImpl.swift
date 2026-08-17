import Supabase

class AuthRepositoryImpl: AuthRepository {
    private let client: SupabaseClient
    private var auth: AuthClient { client.auth }
    
    init(client: SupabaseClient) {
        self.client = client
    }
    
    func loginAnonymously(userHandle: String) async throws {
        try await client.auth.signInAnonymously(
            data: [
                "user_handle": .string(userHandle)
            ]
        )
    }
    
    func logout() async {
        do {
            try await client.auth.signOut()
        } catch {}
    }
    
    func authStateChanges() async -> AsyncStream<(event: AuthChangeEvent,session: Session?)> {
        let subs = client.auth.authStateChanges
        return subs 
    }
}
