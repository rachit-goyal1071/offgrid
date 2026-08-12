import SwiftUI

struct VibeChip: View {
    let vibeName: String
    let isSelected: Bool
    let action: () -> Void
    
    @Environment(Theme.self) private var theme
    var body: some View {
        Button(action: action) {
            Text(vibeName)
                .font(.chipL)
                .foregroundColor(isSelected ?  theme.accentInk : theme.textSecondary)
                .padding(.vertical, 8)
                .padding(.horizontal, 15)
                .background(
                    Capsule()
                        .fill(isSelected ? theme.accentNeon : theme.bgRaised)
                )
                .overlay(
                    Capsule()
                        .stroke(isSelected ? theme.accentNeon : theme.stroke, lineWidth: 1)
                )
                .animation(.easeInOut(duration: 0.25), value: isSelected)
        }
        .buttonStyle(.plain)
    }
}
