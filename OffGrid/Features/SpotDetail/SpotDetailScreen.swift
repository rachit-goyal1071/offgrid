import UIKit
import SwiftUI
import Combine

struct SpotDetailScreen: UIViewControllerRepresentable {
    
    let spot: Spot
    @Environment(Theme.self) private var theme
    private var cancellable = Set<AnyCancellable>()
    
    nonisolated enum Section { case main }

    init(spot: Spot) {
        self.spot = spot
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        SpotDetailViewController(theme: theme, vm: SpotDetailViewModel(), spot: spot)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}
