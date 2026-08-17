import Foundation

protocol SavedSpotRepository {
    
    func getSavedIds() -> Set<UUID>
    
    func isSaved(id: UUID) -> Bool
    
    func toggle(id: UUID)
}
