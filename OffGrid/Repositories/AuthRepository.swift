import Supabase

protocol AuthRepository {
    
    func loginAnonymously() async throws
    
    func logout() async
    
    func authStateChanges() async -> AsyncStream<(event: AuthChangeEvent,session: Session?)>
    
    func claimHandle(_ handle: String) async throws -> HandleUpdateStatus
}
