import Foundation
import Combine

@MainActor
class SavedSpotViewModel: ObservableObject {
    
    enum State: Equatable {
        case loading
        case loaded([Spot])
        case empty
        case failed
    }
    
    @Published private(set) var state: State = .loading
    let spotRepository: SpotRepository
    let savedRepository: SavedSpotRepository
    
    init(spotRepository: SpotRepository, savedRepository: SavedSpotRepository) {
        self.spotRepository = spotRepository
        self.savedRepository = savedRepository
    }
    
    func load() async {
        do {
            state = .loading
            let allSpots = try await spotRepository.fetchSpots()
            let savedSpotIds = savedRepository.getSavedIds()
            let savedSpots = allSpots.filter( { savedSpotIds.contains($0.id) })
            if !savedSpots.isEmpty {
                state = .loaded(savedSpots)
            } else {
                state = .empty
            }
            
        } catch {
            state = .failed
        }
    }
    
    func unsave(id: UUID) async {
        savedRepository.toggle(id: id)
        await load()
    }
}
