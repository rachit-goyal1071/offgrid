protocol SpotRepository {
    
    func fetchSpots() async throws -> [Spot]
    
}
