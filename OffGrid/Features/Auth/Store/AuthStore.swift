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
    
    func login(userHandle: String) async {
        state = .loading
        do {
            try await service.loginAnonymously(userHandle: userHandle)
        } catch {
            print("Failed to login: \(error)")
            state = .failed("Failed to login")
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
                state = .idle
            } else if stream.event == .initialSession {
                if stream.session?.accessToken != nil {
                    state = .loaded
                }
            }
        }
    }
    
    enum ViewState: Equatable {
        case idle
        case loading
        case loaded
        case failed(String)
    }
}
