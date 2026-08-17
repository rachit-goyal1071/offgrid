import SwiftUI
import UIKit

struct SavedScreen: UIViewControllerRepresentable {
    
    @Environment(Theme.self) var theme: Theme
    
    func makeUIViewController(context: Context) -> some UIViewController {
        SavedSpotViewController(theme: theme)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    
}
