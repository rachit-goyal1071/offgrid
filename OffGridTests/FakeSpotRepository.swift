@testable import OffGrid

class FakeSpotRepository: SpotRepository {
    
    var shouldThrow = false
    
    init(shouldThrow: Bool = false) {
        self.shouldThrow = shouldThrow
    }
    
    func fetchSpots() async throws -> [Spot] {
        if shouldThrow {
            throw MockError.unknown
        }
        try await Task.sleep(for: .seconds(2))
        return [Spot.samples[0], Spot.samples[1], Spot.samples[2]]
    }
}
