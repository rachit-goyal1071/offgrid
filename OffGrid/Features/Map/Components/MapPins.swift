import SwiftUI

struct GeneralMapPin: View {
    
    let verified: Bool
    @Environment(Theme.self) private var theme
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(verified ? theme.accentNeon : theme.statusPending, style: StrokeStyle.init(lineWidth: 3))
                .frame(width: 22, height: 22)
            
            Circle()
                .fill(verified ? theme.accentNeon : theme.statusPending)
                .frame(width: 8, height: 8)
        }
    }
}
