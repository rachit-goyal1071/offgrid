import SwiftUI
import UIKit
import MapKit
import CoreLocation

class SpotDetailDescriptionCard: UIView {
    
    let descriptionLabel = UILabel()
    let directionButton = UIButton()
    let saveButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }
    
    func configure(description: String, theme: Theme, coordinates: Coordinates, saveAction: UIAction) {
        descriptionLabel.text = description.lowercased()
        descriptionLabel.font = UIFont.buttonL
        descriptionLabel.textColor = UIColor(theme.textPrimary)
        
        directionButton.setTitleColor(UIColor(theme.accentInk), for: .normal)
        directionButton.layer.backgroundColor = UIColor(theme.accentNeon).cgColor
        directionButton.layer.cornerRadius = 12
        let directionAction = UIAction { [weak self] _  in
            self?.openDirections(coordinates: coordinates)
        }
        directionButton.addAction(directionAction, for: .touchUpInside)
        
        saveButton.layer.backgroundColor = UIColor(theme.bgRaised).cgColor
        saveButton.setTitleColor(UIColor(theme.textPrimary),for: .normal)
        saveButton.layer.cornerRadius = 12
        saveButton.layer.borderColor = UIColor(theme.stroke).cgColor
        saveButton.layer.borderWidth = 1
        saveButton.addAction(saveAction, for: .touchUpInside)
    }
    
    func setupLayout() {
        
        descriptionLabel.numberOfLines = 2
        
        var config = UIButton.Configuration.plain()
        config.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 0, bottom: 12, trailing: 0)
        
        directionButton.setTitle("directions", for: .normal)
        directionButton.titleLabel?.font = UIFont.buttonM
        directionButton.configuration = config
        
        saveButton.setTitle("save", for: .normal)
        saveButton.titleLabel?.font = UIFont.buttonM
        saveButton.configuration = config
        
        let horizontalButtons = linearStackView(views: [directionButton, saveButton], spacing: 12, axis: .horizontal, distribution: .fillEqually, alignment: .fill)
        
        let mainColumn = linearStackView(views: [descriptionLabel, horizontalButtons], spacing: 12, axis: .vertical)
        
        horizontalButtons.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            horizontalButtons.leadingAnchor.constraint(equalTo: mainColumn.leadingAnchor, constant: 0),
            horizontalButtons.trailingAnchor.constraint(equalTo: mainColumn.trailingAnchor, constant: 0),
            horizontalButtons.bottomAnchor.constraint(equalTo: mainColumn.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        self.translatesAutoresizingMaskIntoConstraints = false
        mainColumn.translatesAutoresizingMaskIntoConstraints = false
        addSubview(mainColumn)
        
        NSLayoutConstraint.activate([
            mainColumn.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 14),
            mainColumn.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -14),
            mainColumn.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            mainColumn.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
        ])
    }
    
    func openDirections(coordinates: Coordinates) {
        
        let location = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
        let address = MKAddress(fullAddress: "", shortAddress: "")
        
        let mapItem = MKMapItem(location: location, address: address)
        
        mapItem.openInMaps()
    }
}
