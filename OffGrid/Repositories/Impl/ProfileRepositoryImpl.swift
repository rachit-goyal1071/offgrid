import Supabase

class ProfileRepositoryImpl: ProfileRepository {
    
    let config: SupabaseClient
    
    init(client: SupabaseClient) {
        self.config = client
    }
    
    func getUserProfile() async throws -> ProfileDto {
        do {
            let uid = try await config.auth.session.user.id
            let user: [ProfileDto] = try await config.from("profiles").select().eq("id", value: uid).execute().value
            guard let profile = user.first else { throw GlobalError.profileNotFound }
            return profile
        } catch {
            print(error)
            throw error
        }
    }
}
