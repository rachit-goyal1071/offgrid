import SwiftUI

@MainActor
@Observable
final class MapStore {
    
    private(set) var state: ViewState = .idle
    private var repository: SpotRepository
    
    init(repository: SpotRepository) {
        self.repository = repository
    }
    
    var selectedVibe: Vibe?
    var availableSpots: [Spot] {
        guard case .loaded(let spots) = state else { return [] }
        if selectedVibe == nil { return spots }
        return spots.filter({$0.vibe == selectedVibe})
    }
    
    func load() async {
        state = .loading
        do {
            let spots = try await repository.fetchSpots()
            state = .loaded(spots)
        } catch is CancellationError {
            
        } catch {
            state = .failed("Failed to fetch spots")
        }
    }
    
    enum ViewState {
        case idle
        case loading
        case loaded([Spot])
        case failed(String)
    }
}
