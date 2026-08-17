import UIKit
import SwiftUI

class SavedSpotViewController: UIViewController {
    
    private var theme: Theme
    
    init(theme: Theme) {
        self.theme = theme
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(theme.bgBase)
        let label = UILabel()
        label.text = "saved"
        label.font = UIFont.displayL
        label.textColor = UIColor(theme.textPrimary)
        
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}
