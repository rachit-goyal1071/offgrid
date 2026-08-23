import Supabase

class AuthRepositoryImpl: AuthRepository {
    private let client: SupabaseClient
    private var auth: AuthClient { client.auth }
    
    init(client: SupabaseClient) {
        self.client = client
    }
    
    func loginAnonymously() async throws {
        try await client.auth.signInAnonymously()
    }
    
    func logout() async {
        do {
            try await client.auth.signOut()
        } catch {}
    }
    
    func claimHandle(_ handle: String) async throws -> HandleUpdateStatus {
        do {
            let uid = try await client.auth.session.user.id
            try await client.from("profiles").update(["handle": handle]).eq("id", value: uid).execute()
            return .success
        } catch let error as PostgrestError {
            switch error.code {
            case "23505":
                return .handleAlreadyExists
            case "23514":
                return .invalidLength
            case .none, .some(_):
                return .error
            }
        } catch {
            return .error
        }
    }
    
    func authStateChanges() async -> AsyncStream<(event: AuthChangeEvent,session: Session?)> {
        let subs = client.auth.authStateChanges
        return subs 
    }
}
