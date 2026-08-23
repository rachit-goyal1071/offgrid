import SwiftUI
import UIKit

struct SavedScreen: UIViewControllerRepresentable {
    
    @Environment(Theme.self) var theme: Theme
    
    func makeUIViewController(context: Context) -> some UIViewController {
        SavedSpotViewController(theme: theme, vm: SavedSpotViewModel(spotRepository: container.spotRepository(), savedRepository: container.savedRepository()))
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    
}
