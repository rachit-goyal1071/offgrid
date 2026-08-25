import SwiftUI

struct GeneralMapPin: View {
    
    let verified: Bool
    let isSelected: Bool
    @Environment(Theme.self) private var theme
    @State private var pulse = false
    
    var body: some View {
        ZStack {
            
            if isSelected {
                Circle()
                    .stroke(verified ? theme.accentNeon : theme.statusPending, lineWidth: 2)
                    .frame(width: 22, height: 22)
                    .scaleEffect(pulse ? 2.6 : 0.5)
                    .opacity(pulse ? 0 : 0.9)
                    .onAppear {
                        pulse = false
                        withAnimation(.easeOut(duration: 1.4).repeatForever(autoreverses: false)) {
                            pulse = true
                        }
                    }
            } else {
                Circle()
                    .stroke(verified ? theme.accentNeon : theme.statusPending, lineWidth: 2)
                    .frame(width: 22, height: 22)
            }
            
            Circle()
                .fill(verified ? theme.accentNeon : theme.statusPending)
                .frame(width: 8, height: 8)
        }
    }
}
