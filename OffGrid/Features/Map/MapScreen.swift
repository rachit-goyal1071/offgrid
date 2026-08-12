import SwiftUI
import MapKit

//28.527756,77.256522
struct MapScreen : View {
    
    @Environment(Theme.self) private var theme
    @State private var store: MapStore
    @State private var cameraPosition: MapCameraPosition = .automatic
    private var availableSpots: [Spot] {store.availableSpots}
    
    init() {
        _store = State(initialValue: container.mapStore())
    }
    
    var body: some View {
        Group {
            switch store.state {
            case .idle, .loading:
                SkeletonView()
            case .failed:
                Text("Failed to load spots")
            case .loaded:
                Map(position: $cameraPosition){
                    ForEach(availableSpots) { spot in
                        Annotation(spot.name,coordinate: CLLocationCoordinate2D(latitude: spot.coordinates.latitude,longitude: spot.coordinates.longitude)){
                            GeneralMapPin(verified: spot.verified)
                        }
                    }
                }
                .mapStyle(MapStyle.standard(
                    pointsOfInterest: .excludingAll
                ))
                .safeAreaInset(edge: .top) {
                    vibeRow
                }
                .safeAreaInset(edge: .bottom) {
                    spotsPanel
                }
            }
        }
        .task { await store.load() }
    }
    
    private var vibeRow: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 10) {
                ForEach(Vibe.allCases, id: \.self) { vibe in
                    VibeChip(
                        vibeName: vibe.rawValue,
                        isSelected: store.selectedVibe == vibe,
                        action: {
                            withAnimation(.easeInOut(duration: 0.35)) {
                                store.selectedVibe = (store.selectedVibe == vibe) ? nil : vibe
                                cameraPosition = .automatic
                            }
                        }
                    )
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
        }
        .scrollIndicators(.hidden)
    }
    
    private var spotsPanel: some View {
        VStack(spacing: 12) {
            Capsule()
                .fill(theme.stroke)
                .frame(width: 36, height: 4)
                .padding(12)
            
            HStack(alignment: .center) {
                Text("\(availableSpots.count) spots available for")
                    .font(.buttonM)
                    .foregroundColor(theme.textSecondary)
                
                Text(store.selectedVibe?.rawValue ?? "all vibes")
                    .font(.buttonM)
                    .foregroundColor(theme.accentNeon)
            }
            .padding(.bottom, 12)
            .padding(.leading, 12)
            
            ScrollView(.horizontal) {
                HStack(spacing: 12) {
                    ForEach(availableSpots) { spot in
                        SpotCard(spot: spot)
                    }
                }
                .padding(.horizontal, 10)
            }
            .padding(.bottom, 12)
        }
        .background(theme.bgRaised)
        //        .overlay(
        //            Rectangle()
        //                .fill(theme.stroke)
        //                .frame(height: 1)
        //                .clipShape(RoundedRectangle(cornerRadius: 20))
        ////            UnevenRoundedRectangle(
        ////                cornerRadii: RectangleCornerRadii(topLeading: 20, bottomLeading: 20, bottomTrailing: 20, topTrailing: 20)
        ////            )
        ////            .frame(height: 1)
        //        )
        .frame(maxWidth: .infinity)
        .frame(height: 274)
    }
}
