import UIKit
import SwiftUI

class SpotCell: UICollectionViewCell {
    
    private var theme: Theme
    private var spot: Spot
    private var quoteText: String
    
    init(frame: CGRect, theme: Theme, spot: Spot, quoteText: String) {
        self.theme = theme
        self.quoteText = quoteText
        self.spot = spot
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var contentView: UIView {
        let view = UIStackView()
        
        view.backgroundColor = UIColor(theme.bgRaised)
        view.layer.cornerRadius = 16
        view.layer.cornerCurve = .continuous
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = UIColor(theme.stroke).cgColor
        view.layer.borderWidth = 1.0
        return view
    }
    
    func dataRow(views: [UIView]) -> UIView {
        let view = UIStackView()
        
        views.forEach { view.addArrangedSubview($0) }
        view.axis = .horizontal
        return view
    }
    
    var spotLabel: UIView {
        let label = UILabel()
        
        label.text = spot.name
        label.textColor = UIColor(theme.textPrimary)
        label.font = UIFont.heading
        return label
    }
    
    var quoteLabel: UIView {
        let label = UILabel()
        
        label.text = quoteText
        label.textColor = UIColor(theme.textSecondary)
        label.font = UIFont.body
        return label
    }
    
    var handleLabel: UIView {
        let label = UILabel()
        
        label.text = "\(spot.posterHandle) •"
        label.textColor = UIColor(theme.textSecondary)
        label.font = UIFont.caption
        return label
    }
    
    var statusText: UIView {
        let view = UIStackView()
        let label = UILabel()
        let verifiedTick = UIImageView()
        
        verifiedTick.image = UIImage(systemName: "checkmark.circle.fill")
        verifiedTick.tintColor = UIColor(theme.accentNeon)
        view.axis = .horizontal
        
        if spot.verified {
            label.textColor = UIColor(theme.accentNeon)
            label.text = "local"
            label.font = UIFont.caption
            view.addArrangedSubview(verifiedTick)
        } else {
            label.textColor = UIColor(theme.statusPending)
            label.text = "pending"
        }
        
        view.addArrangedSubview(label)
        
        return view
    }
    
    var vibeChip: UIView {
        let view = UIView()
        let label = UILabel()
        
        layer.borderColor = UIColor(theme.accentNeon).withAlphaComponent(0.35).cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 999
        label.text = spot.name
        label.textColor = UIColor(theme.accentNeon)
        label.font = UIFont.monoStamp
        view.insertSubview(label, at: 0)
        label.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 3, leading: 9, bottom: 3, trailing: 9)
        
        return view
    }
}
