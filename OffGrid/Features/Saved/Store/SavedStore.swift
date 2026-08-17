import SwiftUI

@MainActor
@Observable
class SavedStore {
    
    private var repository: SavedSpotRepository
    private var saved: Set<UUID>
    
    init(repository: SavedSpotRepository) {
        self.repository = repository
        saved = repository.getSavedIds()
    }
    
    func isSaved(id: UUID) -> Bool {
        saved.contains(id)
    }
    
    func toggle(id: UUID) {
        repository.toggle(id: id)
        saved = repository.getSavedIds()
    }
}
