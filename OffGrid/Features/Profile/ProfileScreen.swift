import SwiftUI

struct ProfileScreen: View {
    
    @State private var store: AuthStore
    @State private var profileStore: ProfileStore
    @Environment(Theme.self) var theme
    @Environment(AppCoordinator.self) private var app
    private var user: User? { profileStore.user }
    
    init() {
        _store = State(initialValue: container.authStore)
        _profileStore = State(initialValue: container.profileStore)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20){
            
            Button(action: {
                if user?.handle == nil {
                    app.modal = .claimHandle
                }
            }) {
                switch profileStore.state {
                case .loading:
                    ProgressView()
                default:
                    Text(user?.handle == nil ? "claim handle" : "@\(user?.handle ?? "")")
                        .font(.titleS)
                        .foregroundStyle(theme.textPrimary)
                }
            }
            
            Button(action: {
                Task {
                    await store.logout()
                }
            }){
                Text("Logout")
                    .font(.displayL)
            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 12)
        .task {
            await profileStore.getUser()
        }
    }
}
