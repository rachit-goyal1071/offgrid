import UIKit
import SwiftUI

class SpotDetailNameInfoCard: UIView {
    
    private let spotLabel = UILabel()
    private let vibeLabel = UILabel()
    private let upvoteCountLabel = UILabel()
    private let distanceLabel = UILabel()
    private let chipContainer = UIView()
    private let arrowUp = UIImageView()
    private let arrowDown = UIImageView()
    private let upvoteContainer = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }
    
    func configure(theme: Theme, spotName: String, vibe: Vibe, distance: Double, upvotes: Int) {
        
        spotLabel.text = spotName.lowercased()
        spotLabel.textColor = UIColor(theme.textPrimary)
        
        vibeLabel.text = vibe.rawValue
        vibeLabel.textColor = UIColor(theme.accentInk)
        
        chipContainer.layer.backgroundColor = UIColor(theme.accentNeon).cgColor
        
        distanceLabel.text = "\(distance) km"
        distanceLabel.textColor = UIColor(theme.textSecondary)
        
        upvoteCountLabel.text = "\(upvotes)"
        upvoteCountLabel.textColor = UIColor(theme.accentNeon)
        
        arrowUp.tintColor = UIColor(theme.textSecondary)
        arrowDown.tintColor = UIColor(theme.textSecondary)
        
        upvoteContainer.layer.backgroundColor = UIColor(theme.bgRaised).cgColor
        upvoteContainer.layer.borderColor = UIColor(theme.stroke).cgColor
        
    }
    
    func setupLayout() {
        
        // MARK: - Name Label
        spotLabel.font = UIFont.titleS
        spotLabel.numberOfLines = 2
        spotLabel.lineBreakMode = .byTruncatingTail
        
        // MARK: - Upvote arrows and count window
        upvoteContainer.layer.borderWidth = 1.0
        upvoteContainer.layer.cornerRadius = 14.0
        
        arrowUp.image = UIImage(systemName: "arrow.up")
        arrowUp.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            arrowUp.widthAnchor.constraint(equalToConstant: 26),
            arrowUp.heightAnchor.constraint(equalToConstant: 18)
        ])
        upvoteCountLabel.font = UIFont.buttonM
        upvoteCountLabel.lineBreakMode = .byTruncatingTail
        arrowDown.image = UIImage(systemName: "arrow.down")
        arrowDown.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            arrowDown.widthAnchor.constraint(equalToConstant: 26),
            arrowDown.heightAnchor.constraint(equalToConstant: 18)
        ])
        
        let upvoteStack = linearStackView(views: [arrowUp, upvoteCountLabel, arrowDown], spacing: 2, axis: .vertical, distribution: .fill, alignment: .center)
        upvoteStack.translatesAutoresizingMaskIntoConstraints = false
        
        upvoteContainer.addSubview(upvoteStack)
        
        NSLayoutConstraint.activate([
            upvoteContainer.widthAnchor.constraint(equalToConstant: 46),
            upvoteStack.leadingAnchor.constraint(equalTo: upvoteContainer.leadingAnchor, constant: 4),
            upvoteStack.trailingAnchor.constraint(equalTo: upvoteContainer.trailingAnchor, constant: -4),
            upvoteStack.topAnchor.constraint(equalTo: upvoteContainer.topAnchor, constant: 3),
            upvoteStack.bottomAnchor.constraint(equalTo: upvoteContainer.bottomAnchor, constant: -3),
        ])
        
        // MARK: - Vibe Chip Container
        chipContainer.layer.borderWidth = 1.0
        chipContainer.layer.cornerRadius = 10
        
        vibeLabel.font = UIFont.caption
        vibeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        chipContainer.insertSubview(vibeLabel, at: 0)
        chipContainer.setContentHuggingPriority(.required, for: .horizontal)
        
        NSLayoutConstraint.activate([
            vibeLabel.leadingAnchor.constraint(equalTo: chipContainer.leadingAnchor, constant: 9),
            vibeLabel.trailingAnchor.constraint(equalTo: chipContainer.trailingAnchor, constant: -9),
            vibeLabel.topAnchor.constraint(equalTo: chipContainer.topAnchor, constant: 3),
            vibeLabel.bottomAnchor.constraint(equalTo: chipContainer.bottomAnchor, constant: -3),
        ])
        
        // MARK: - Distance Label
        distanceLabel.font = UIFont.buttonM
        
        // MARK: - Bottom Info Row
        let horizontalSpacer = UIView()
        horizontalSpacer.setContentHuggingPriority(.defaultLow, for: .horizontal)
        let infoSpacer = UIView()
        infoSpacer.setContentHuggingPriority(UILayoutPriority(1), for: .horizontal)
        
        let infoRow = linearStackView(
            views: [chipContainer, distanceLabel, horizontalSpacer],
            spacing: 8,
            axis: .horizontal,
            distribution: .fill,
            alignment: .center
        )
        
        // MARK: - Name and Info Column
        let nameAndInfoColumn = linearStackView(views: [spotLabel, infoRow, infoSpacer], spacing: 8, axis: .vertical, distribution: .fill)
        
        // MARK: - Main Data Row
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let mainDataRow = linearStackView(views: [nameAndInfoColumn, upvoteContainer], spacing: 16, axis: .horizontal, distribution: .fill)
    
        self.addSubview(mainDataRow)
        
        mainDataRow.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainDataRow.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 14),
            mainDataRow.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -14),
            mainDataRow.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            mainDataRow.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
        ])
        
    }
}
