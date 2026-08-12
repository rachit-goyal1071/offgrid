import SwiftUI

@MainActor
@Observable
final class SessionStore {
    private enum Key {
        static let isLoggedIn = "isLoggedIn"
        static let authToken = "authToken"
        static let refreshToken = "refreshToken"
        static let userID = "userID"
        static let userHandle = "userHandle"
    }
    
    @ObservationIgnored private let defaults = UserDefaults.standard
    
    var isLoggedIn: Bool {
        get { defaults.bool(forKey: .init(Key.isLoggedIn)) }
        set { defaults.set(newValue, forKey: .init(Key.isLoggedIn)) }
    }
    
    var authToken: String? {
        get { defaults.string(forKey: .init(Key.authToken)) }
        set { defaults.set(newValue, forKey: .init(Key.authToken)) }
    }
    
    var refreshToken: String? {
        get { defaults.string(forKey: .init(Key.refreshToken)) }
        set { defaults.set(newValue, forKey: .init(Key.refreshToken)) }
    }
    
    var userID: UUID? {
        get { defaults.string(forKey: Key.userID).flatMap { UUID(uuidString: $0) } }
        set { defaults.set(newValue?.uuidString, forKey: Key.userID) } }
    
    var userHandle: String? {
        get { defaults.string(forKey: .init(Key.userHandle)) }
        set { defaults.set(newValue, forKey: .init(Key.userHandle)) }
    }
    
    func clearSession() {
        isLoggedIn = false
        authToken = nil
        refreshToken = nil
        userID = nil
        userHandle = nil
    }
}
