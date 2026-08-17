@testable import OffGrid
import Foundation

class FakeSavedSpotRepository: SavedSpotRepository {
    
    
    var set: Set<UUID>
    
    init(set: Set<UUID>) {
        self.set = set
    }
    
    func getSavedIds() -> Set<UUID> {
        set
    }
    
    func isSaved(id: UUID) -> Bool {
        set.contains(id)
    }
    
    func toggle(id: UUID) {
        if set.contains(id) {
            set.remove(id)
        } else {
            set.insert(id)
        }
    }
}

