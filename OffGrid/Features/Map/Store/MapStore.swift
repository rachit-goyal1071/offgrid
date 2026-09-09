import SwiftUI

@MainActor
@Observable
final class MapStore {
    
    private(set) var state: ViewState = .idle
    private var repository: SpotRepository
    var selectedVibe: Vibe?
    var selectedPin: Spot.ID?
    
    init(repository: SpotRepository) {
        self.repository = repository
    }
    
    func toggleSelection(_ id: Spot.ID) {
        selectedPin = (selectedPin == id) ? nil : id
        
    }
    
    var availableSpots: [Spot] {
        guard case .loaded(let spots) = state else { return [] }
        if selectedVibe == nil && selectedPin == nil { return spots }
        return spots.filter({$0.vibe == selectedVibe || $0.id == selectedPin})
    }
    
    func load() async {
        state = .loading
        guard availableSpots.isEmpty else { return }
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
