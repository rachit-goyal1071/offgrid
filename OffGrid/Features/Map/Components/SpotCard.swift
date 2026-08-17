import SwiftUI

struct SpotCard: View {
    var spot: Spot
    
    @Environment(Theme.self) private var theme
    @State var savedStore: SavedStore
    
    init (spot: Spot) {
        _savedStore = State(initialValue: container.savedStore)
        self.spot = spot
    }
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0){
            AsyncImage(url: URL(string: spot.images.first ?? "https://elements-resized.envatousercontent.com/envato-dam-assets-production/EVA/TRX/8f/8f/14/5c/e9/v1_E10/E104VR5E.jpg?w=1600&cf_fit=scale-down&mark-alpha=18&mark=https%3A%2F%2Felements-assets.envato.com%2Fstatic%2Fwatermark4.png&q=85&format=auto&s=b4cc8a1341b7764a72109042d26f9657b48e11b41da961e5a39ffe3845b16fbc")) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Rectangle().fill(theme.bgRaised)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 92)
            .clipped()
            .overlay(alignment: .bottomLeading) {
                Text("photo • \(getCreatedAt)")
                    .padding(.vertical, 2)
                    .padding(.horizontal, 6)
                    .font(.monoStamp)
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .fill(theme.bgRaised.opacity(0.8))
                    )
                    .foregroundStyle(theme.textTertiary)
                    .frame(alignment: .leading)
                    .lineLimit(1)
                    .padding(.leading, 8)
                    .padding(.bottom, 8)
            }
            .overlay(alignment: .topTrailing) {
                Button(action: {
                    savedStore.toggle(id: spot.id)
                }) {
                    Image(systemName: savedStore.isSaved(id: spot.id) ? "bookmark.fill" : "bookmark")
                        .resizable()
                        .frame(width: 12)
                        .frame(height: 14)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 9)
                        .foregroundStyle(
                            savedStore.isSaved(id: spot.id) ? theme.accentNeon : theme.textPrimary
                        )
                        .animation(.easeInOut(duration: 0.15), value: savedStore.isSaved(id: spot.id))
                        .background(
                            RoundedRectangle(cornerRadius: 999)
                                .fill(theme.bgRaised.opacity(0.8))
                        )
                        .padding(.top, 8)
                        .padding(.trailing, 8)
                        .frame(width: 44)
                        .frame(height: 44)
                        .containerShape(Rectangle())
                }
            }
            
            VStack(alignment: .leading, spacing: 0){
                Text(spot.name.lowercased())
                    .font(.heading)
                    .foregroundStyle(theme.textPrimary)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack{
                    Text("1.2 km")
                        .font(.caption)
                        .foregroundColor(theme.textSecondary)
                    if spot.upvotes >= 0 {
                        Image(systemName: "chevron.up")
                            .foregroundStyle(theme.accentNeon)
                            .font(.caption)
                    }
                    else {
                        Image(systemName: "chevron.down")
                            .foregroundStyle(theme.accentNeon)
                            .font(.caption)
                    }
                    
                    Text("\(spot.upvotes)")
                        .font(.caption)
                        .foregroundStyle(theme.accentNeon)
                }
                .padding(.top, 2)
                
                HStack{
                    Text("\(spot.posterHandle) •") //TODO: Create refrencing for createdBy
                        .font(.caption)
                        .foregroundStyle(theme.textSecondary)
                        .clipped(antialiased: false)
                    
                    if spot.verified {
                        Image(systemName: "checkmark")
                            .foregroundStyle(theme.accentNeon)
                            .font(.caption)
                        
                        Text("verified")
                            .font(.caption)
                            .foregroundStyle(theme.accentNeon)
                    }
                    else {
                        Text("unverified")
                            .font(.caption)
                            .foregroundStyle(theme.statusPending)
                    }
                }
                .padding(.top, 2)
                
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 12)
            
        }
        .frame(width: 200, height: 188, alignment: .top)
        .background(RoundedRectangle(cornerRadius: 16).fill(theme.bgPressed))
    }
    
    var getCreatedAt: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: spot.createdAt, relativeTo: Date())
    }
    
}
