import UIKit
import SwiftUI

class SpotCell: UICollectionViewCell {
    
    private var theme: Theme?
    private var spot: Spot?
    let stackView = UIStackView()
    let spotLabel = UILabel()
    let quoteLabel = UILabel()
    let handleLabel = UILabel()
    let chipContainer = UIView()
    let vibeLabel = UILabel()
    let verifiedTick = UIImageView()
    let statusLabel = UILabel()
    let statusText = UIStackView()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func configure(spot: Spot, theme: Theme) {
        self.spot = spot
        self.theme = theme
        contentView.backgroundColor = UIColor(theme.bgRaised)
        contentView.layer.borderColor = UIColor(theme.stroke).cgColor
        
        spotLabel.text = spot.name
        spotLabel.textColor = UIColor(theme.textPrimary)
        
        quoteLabel.text = spot.description
        quoteLabel.textColor = UIColor(theme.textSecondary)
        
        handleLabel.text = "\(spot.posterHandle) •"
        handleLabel.textColor = UIColor(theme.textSecondary)
        
        verifiedTick.tintColor = UIColor(theme.accentNeon)
        
        if spot.verified {
            statusLabel.text = "local"
            statusLabel.textColor = UIColor(theme.accentNeon)
            verifiedTick.isHidden = false
            
        } else {
            statusLabel.text = "pending"
            statusLabel.textColor = UIColor(theme.statusPending)
            verifiedTick.isHidden = true
        }
        
        chipContainer.layer.borderColor = UIColor(theme.accentNeon).cgColor
        
        vibeLabel.text = spot.vibe.rawValue
        vibeLabel.textColor = UIColor(theme.accentNeon)
    }
    
    func setupViews() {

        contentView.layer.cornerRadius = 16
        contentView.layer.borderWidth = 1.0
        contentView.layer.cornerCurve = .continuous
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        
        self.contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 14),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -14),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
        ])
        
        let spacer = UIView()
        spacer.setContentHuggingPriority(UILayoutPriority(1), for: .horizontal)
        
        let rowOne = dataRow(views: [spotView])
        let rowTwo = dataRow(views: [quoteView])
        let rowThree = dataRow(views: [vibeChip, handleView, statusView, spacer])
        
        [rowOne, rowTwo, rowThree].forEach { stackView.addArrangedSubview($0) }
    }
    
    func dataRow(views: [UIView], spacing: CGFloat = 8) -> UIView {
        let view = UIStackView()
        view.spacing = spacing
        
        views.forEach { view.addArrangedSubview($0) }
        view.axis = .horizontal
        return view
    }
    
    var spotView: UIView {
        spotLabel.font = UIFont.heading
        return spotLabel
    }

    var quoteView: UIView {
        quoteLabel.font = UIFont.body
        quoteLabel.numberOfLines = 0
        return quoteLabel
    }
    
    var vibeChip: UIView {
        chipContainer.layer.borderWidth = 1.0
        chipContainer.layer.cornerRadius = 10
        vibeLabel.font = UIFont.monoStamp
        chipContainer.insertSubview(vibeLabel, at: 0)
        chipContainer.setContentHuggingPriority(.required, for: .horizontal)
        vibeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            vibeLabel.leadingAnchor.constraint(equalTo: chipContainer.leadingAnchor, constant: 9),
            vibeLabel.trailingAnchor.constraint(equalTo: chipContainer.trailingAnchor, constant: -9),
            vibeLabel.topAnchor.constraint(equalTo: chipContainer.topAnchor, constant: 3),
            vibeLabel.bottomAnchor.constraint(equalTo: chipContainer.bottomAnchor, constant: -3),
        ])
        
        return chipContainer
    }

    var handleView: UIView {
        handleLabel.font = UIFont.caption
        return handleLabel
    }

    var statusView: UIView {
        verifiedTick.image = UIImage(systemName: "checkmark")

        statusText.axis = .horizontal
        statusLabel.font = UIFont.caption
        
        statusText.addArrangedSubview(verifiedTick)
        statusText.addArrangedSubview(statusLabel)
        
        return statusText
    }
}
