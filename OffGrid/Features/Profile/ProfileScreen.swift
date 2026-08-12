import SwiftUI

struct ProfileScreen: View {
    @State private var store: AuthStore
    private let onLogout: () -> Void
    init(onLogout: @escaping () -> Void) {
        _store = State(initialValue: container.authStore())
        self.onLogout = onLogout
    }
    
    var body: some View {
        Text("Profile Screen")
            .font(.displayL)
            .onAppear {
                store.logout()
                onLogout()
            }
    }
}
