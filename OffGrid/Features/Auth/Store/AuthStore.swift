import SwiftUI

@MainActor
@Observable
final class AuthStore {
    
    private let service: AuthService
    private(set) var state: ViewState = .idle
    
    init(service: AuthService) {
        self.service = service
    }
    
    func login(userHandle: String) async {
        state = .loading
        try? await Task.sleep(for: .seconds(4))
        do {
            try await service.loginAnonymously(userHandle: userHandle)
            state = .loaded(userHandle)
        } catch {
            print("Failed to login: \(error)")
            state = .failed("Failed to login")
        }
    }
    
    func logout() {
        service.logout()
        state = .idle
    }
    
    enum ViewState: Equatable {
        case idle
        case loading
        case loaded(String)
        case failed(String)
    }
}
