import SwiftUI
import UIKit

class SpotDetailUserInfoCard: UIView {
    
    private let mainView = UIView()
    private let handleLabel = UILabel()
    private let statusLabel = UILabel()
    private let verifiedTickImage = UIImageView()
    private let lastCheckedInLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }
    
    func configure(handle: String, lastCheckedIn: String, isVerified: Bool, status: String, theme: Theme) {
        handleLabel.text = handle
        handleLabel.textColor = UIColor(theme.textPrimary)
        
        verifiedTickImage.tintColor = UIColor(isVerified ? theme.accentNeon : theme.statusPending)
        verifiedTickImage.image = isVerified ? UIImage(systemName: "checkmark") : nil
        
        statusLabel.text = isVerified ? status : "pending"
        statusLabel.textColor = UIColor(theme.accentNeon)
        
        lastCheckedInLabel.text = "last checked in: \(lastCheckedIn)"
        lastCheckedInLabel.textColor = UIColor(theme.textSecondary)
        
        mainView.backgroundColor = UIColor(theme.bgRaised)
        mainView.layer.borderColor = UIColor(theme.stroke).cgColor
    }
    
    func setupLayout() {
        
        handleLabel.font = UIFont.heading
        statusLabel.font = UIFont.heading
        lastCheckedInLabel.font = UIFont.heading
        
        let spacer = UIView()
        spacer.setContentHuggingPriority(UILayoutPriority(1), for: .horizontal)
        let topRow = linearStackView(views: [handleLabel, verifiedTickImage, statusLabel, spacer], spacing: 4, axis: .horizontal, distribution: .fill)
        let dataColumn = linearStackView(views: [topRow, lastCheckedInLabel], axis: .vertical)
        
        dataColumn.translatesAutoresizingMaskIntoConstraints = false
        
        mainView.layer.borderWidth = 1
        mainView.layer.cornerRadius = 14
        
        mainView.addSubview(dataColumn)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dataColumn.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 10),
            dataColumn.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -10),
            dataColumn.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 16),
            dataColumn.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16),
        ])
        
        self.addSubview(mainView)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            mainView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            mainView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 14),
            mainView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -14),
        ])
    }
}
