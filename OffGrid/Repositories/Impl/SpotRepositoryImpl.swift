import Supabase

class SpotRepositoryImpl: SpotRepository {
    private let client: SupabaseClient
    
    init(client: SupabaseClient) {
        self.client = client
    }
    
    func fetchSpots() async throws -> [Spot] {
        let response: [SpotRowDto] = try await client.from("spots").select().execute().value
        return try response.map { try $0.toDomain() }
    }
}
