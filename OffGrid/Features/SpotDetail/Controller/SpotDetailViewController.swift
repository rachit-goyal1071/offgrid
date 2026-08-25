import UIKit

class SpotDetailViewController: UIViewController {
    
    private var theme: Theme
    private var vm: SpotDetailViewModel
    private let contentStack = UIStackView()
    private let spot: Spot
    private let nameInfoCard = SpotDetailNameInfoCard()
    
    init(theme: Theme, vm: SpotDetailViewModel, spot: Spot) {
        self.theme = theme
        self.vm = vm
        self.spot = spot
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView(frame: .zero)
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private func configureViews() {
        nameInfoCard.configure(theme: self.theme, spotName: spot.name, vibe: spot.vibe, distance: 1.3, upvotes: spot.upvotes)
        view.addSubview(scrollView)
        let safeArea = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
        scrollView.addSubview(contentStack)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.addArrangedSubview(nameInfoCard)
        contentStack.axis = .vertical
    }
    
}
