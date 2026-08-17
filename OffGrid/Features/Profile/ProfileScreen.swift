import SwiftUI

struct ProfileScreen: View {
    @State private var store: AuthStore
    
    init() {
        _store = State(initialValue: container.authStore)
    }
    
    var body: some View {
        VStack(spacing: 20){
            Text("Profile Screen")
                .font(.displayL)
            
            Button(action: {
                Task {
                    await store.logout()
                }
            }){
                Text("Logout")
                    .font(.displayL)
            }
        }
    }
}
