import Foundation
import Combine

class SpotDetailViewModel: ObservableObject {
    
    @Published private(set) var state: State = .empty
    
    enum State: Equatable {
        case loading
        case loaded
        case empty
        case failed
    }
    
}
