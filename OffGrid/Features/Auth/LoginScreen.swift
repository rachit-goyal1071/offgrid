import SwiftUI

struct LoginScreen: View {
    
    @Environment(Theme.self) private var theme: Theme
    @State private var handle: String = ""
    @State private var store: AuthStore
    
    init() {
        _store = State(initialValue: container.authStore)
    }
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("claim your handle")
                .font(.displayL)
                .foregroundStyle(theme.textPrimary)
            
            Text("this is what shows next to your pins. pick something you'd shout across a street.")
                .font(.headline)
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
                    }
            }
            .padding(10)
            .frame(maxWidth: .greatestFiniteMagnitude)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(theme.bgRaised)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(theme.accentNeon, lineWidth: 1)
            )
            
            Text("lowercase only, obviously. you can change it once a year.")
                .font(.headline)
                .foregroundStyle(theme.textTertiary)
            
            Button(action: {
                Task {
                    guard store.state != .loading else { return }
                    await store.login(userHandle: handle)
                }
            }) {
                switch store.state {
                case .loading:
                    ProgressView()
                        .tint(theme.accentInk)
                case .loaded, .failed, .idle:
                    Text("that's me")
                        .font(.headline)
                        .foregroundStyle(theme.accentInk)
                }
            }
            .frame(maxWidth: .greatestFiniteMagnitude)
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
