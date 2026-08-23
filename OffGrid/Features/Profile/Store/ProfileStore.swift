import SwiftUI

@Observable
class ProfileStore {
    
    var user: User?
    private var repository: ProfileRepository
    private var authRepository: AuthRepository
    var state: ProfileState = .initial
    var handleState: HandleState = .initial
    
    init(repository: ProfileRepository, authRepository: AuthRepository) {
        self.repository = repository
        self.authRepository = authRepository
    }
    
    enum ProfileState {
        case initial
        case loading
        case loaded
        case empty
    }
    
    enum HandleState {
        case initial
        case loading
        case loaded
        case error
    }
    
    func getUser() async {
        guard state != .loaded else { return }
        do {
            state = .loading
            let value = try await repository.getUserProfile()
            user = value.toDomain()
            state = .loaded
        } catch {
            debugPrint("User Loading error \(error)")
        }
    }
    
    func claimHandle(handle: String) async -> HandleUpdateStatus {
        handleState = .loading
        do {
            let result = try await authRepository.claimHandle(handle)
            if result == .success {
                user = user?.copyWith(handle: handle)
                handleState = .loaded
            } else {
                handleState = .initial
            }
            return result
        } catch {
            handleState = .error
            return .error
        }
    }
}
