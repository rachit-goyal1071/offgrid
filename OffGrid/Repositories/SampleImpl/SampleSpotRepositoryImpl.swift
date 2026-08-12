class SampleSpotRepositoryImpl: SpotRepository {
    
    func fetchSpots() async throws -> [Spot] {
        try await Task.sleep(for: .seconds(2))
        return Spot.samples
    }
}
