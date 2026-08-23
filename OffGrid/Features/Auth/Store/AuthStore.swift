import SwiftUI
import Supabase

@MainActor
@Observable
final class AuthStore {
    
    private let service: AuthRepository
    private(set) var state: ViewState = .idle
    
    init(service: AuthRepository) {
        self.service = service
    }
    
    func login() async {
        do {
            try await service.loginAnonymously()
        } catch {
            debugPrint("Failed to login: \(error)")
            state = .failed
        }
    }
    
    func logout() async {
        await service.logout()
        state = .idle
    }
    
    func listenAuthEvents() async {
        let streams = await service.authStateChanges()
        for await stream in streams {
            if stream.event == .signedIn {
                state = .loaded
            } else if stream.event == .signedOut {
                state = .loggedOut
            } else if stream.event == .initialSession {
                if stream.session?.accessToken != nil {
                    state = .loaded
                } else {
                    state = .loggedOut
                }
            }
        }
    }
    
    enum ViewState: Equatable {
        case idle
        case loading
        case loaded
        case failed
        case loggedOut
    }
}
