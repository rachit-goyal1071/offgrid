import UIKit

func linearStackView(views: [UIView], spacing: CGFloat = 8, axis: NSLayoutConstraint.Axis ) -> UIView {
    let view = UIStackView()
    
    view.spacing = spacing
    view.axis = axis
    views.forEach { view.addArrangedSubview($0) }
    
    return view
}
