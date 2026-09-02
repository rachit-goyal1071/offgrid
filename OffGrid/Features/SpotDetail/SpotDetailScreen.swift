import UIKit
import SwiftUI
import Combine

struct SpotDetailScreen: UIViewControllerRepresentable {
    
    let spot: Spot
    @Environment(Theme.self) private var theme
    private var cancellable = Set<AnyCancellable>()
    @State private var store: SavedStore
    
    nonisolated enum Section { case main }

    init(spot: Spot) {
        self.spot = spot
        _store = State(initialValue: container.savedStore)
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        SpotDetailViewController(theme: theme, vm: SpotDetailViewModel(), spot: spot, store: store)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}
