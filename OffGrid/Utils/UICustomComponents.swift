import UIKit

func linearStackView(views: [UIView], spacing: CGFloat = 8, axis: NSLayoutConstraint.Axis, distribution: UIStackView.Distribution = .equalSpacing, alignment: UIStackView.Alignment = .leading) -> UIView {
    let view = UIStackView()
    
    view.spacing = spacing
    view.axis = axis
    view.distribution = distribution
    views.forEach { view.addArrangedSubview($0) }
    view.alignment = alignment
    
    return view
}
