import Foundation

class UserDefaultsSavedSpotRepositoryImpl: SavedSpotRepository {
    
    private enum Key {
        static let savedIds = "savedIds"
    }
    
    private let defaults = UserDefaults.standard
    
    private var savedIds: [String] {
        get { defaults.stringArray(forKey: Key.savedIds) ?? [] }
        set { defaults.set(newValue, forKey: Key.savedIds) }
    }
    
    private func add(id: String) {
        savedIds.append(id)
    }
    
    private func remove(id: String) {
        savedIds.removeAll { $0 == id }
    }
    
    func getSavedIds() -> Set<UUID> {
        return Set(savedIds.compactMap { UUID(uuidString: $0)})
    }
    
    func isSaved(id: UUID) -> Bool {
        savedIds.contains(id.uuidString)
    }
    
    func toggle(id: UUID) {
        let idVal = id.uuidString
        savedIds.contains(idVal) ? remove(id: idVal) : add(id: idVal)
    }
}
