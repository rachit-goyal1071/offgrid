import SwiftUI

struct HandleClaimSheet: View {
    
    @Environment(Theme.self) private var theme: Theme
    @State private var handle: String = ""
    @State private var store: ProfileStore
    @State private var status: HandleUpdateStatus = .unknown
    @Environment(AppCoordinator.self) private var app
    
    init() {
        _store = State(initialValue: container.profileStore)
    }
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("claim your handle")
                .font(.displayL)
                .foregroundStyle(theme.textPrimary)
            
            Text("this is what shows next to your pins. pick something you'd shout across a street.")
                .font(.heading)
                .foregroundStyle(theme.textSecondary)
            
            HStack(spacing: 4) {
                Text("@")
                    .foregroundStyle(theme.textTertiary)
                    .font(.body)
                
                TextField("username", text: $handle)
                    .textFieldStyle(.plain)
                    .foregroundStyle(theme.textPrimary)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                    .onChange(of: handle) { _, newValue in
                        handle = newValue.lowercased()
                        status = .unknown
                    }
                Spacer()
                if status == .handleAlreadyExists {
                    Text("taken")
                        .foregroundStyle(theme.statusNegative)
                        .font(.chipS)
                }
            }
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(theme.bgRaised)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(
                        status == .error || status == .handleAlreadyExists || status == .invalidLength ?
                        theme.statusNegative : theme.accentNeon,
                        lineWidth: 1
                    )
            )
            
            Text("lowercase only, obviously. you can change it once a year.")
                .font(.heading)
                .foregroundStyle(theme.textTertiary)
            
            Button(action: {
                Task {
                    guard store.handleState != .loading else { return }
                    guard handle.count > 3 else { return }
                    status = await store.claimHandle(handle: handle)
                    if status == .success {
                        app.modal = nil
                    }
                    debugPrint("Current status is \(status)")
                }
            }) {
                switch store.handleState {
                case .loading:
                    ProgressView()
                        .tint(theme.accentInk)
                default:
                    Text("that's me")
                        .font(.heading)
                        .foregroundStyle(theme.accentInk)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(theme.accentNeon)
            )
            .frame(alignment: .center)
            
            Spacer()
        }
        .frame(alignment: .topLeading)
        .padding(.horizontal, 20)
        .padding(.top, 20)
    }
}
