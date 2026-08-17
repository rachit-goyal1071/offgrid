import Supabase

protocol AuthRepository {
    
    func loginAnonymously(userHandle: String) async throws
    
    func logout() async
    
    func authStateChanges() async -> AsyncStream<(event: AuthChangeEvent,session: Session?)>
}
