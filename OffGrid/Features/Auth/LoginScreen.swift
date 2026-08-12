import SwiftUI

struct LoginScreen: View {
    
    @Environment(Theme.self) private var theme: Theme
    @State private var handle: String = ""
    @State private var store: AuthStore
    private let onSuccess: () -> Void
    
    init(onSuccess: @escaping () -> Void) {
        _store = State(initialValue: container.authStore())
        self.onSuccess = onSuccess
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
                    await store.login(userHandle: handle)
                }
            }) {
                switch store.state {
                case .loading:
                    ProgressView()
                        .foregroundStyle(theme.textPrimary)
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
        .onChange(of: store.state) {_, newState in
            if case .loaded = newState {
                onSuccess()
            }
        }
        .frame(alignment: .topLeading)
        .padding(.horizontal, 20)
        .padding(.top, 20)
    }
}
