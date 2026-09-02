import UIKit

class SpotDetailViewController: UIViewController {
    
    private var theme: Theme
    private var vm: SpotDetailViewModel
    private let contentStack = UIStackView()
    private let spot: Spot
    private let nameInfoCard = SpotDetailNameInfoCard()
    private let carousalCard = SpotDetailImageCarousel()
    private let spotDetailDescriptionCard = SpotDetailDescriptionCard()
    private let spotDetailUserInfoCard = SpotDetailUserInfoCard()
    private let savedStore: SavedStore
    
    init(theme: Theme, vm: SpotDetailViewModel, spot: Spot, store: SavedStore) {
        self.theme = theme
        self.vm = vm
        self.spot = spot
        self.savedStore = store
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
        carousalCard.configure(theme: theme, images: spot.images, createdAt: spot.createdAt)
        spotDetailDescriptionCard.configure(
            description: spot.description ?? "",
            theme: theme, coordinates: spot.coordinates,
            saveAction: UIAction { [weak self] _ in
            guard self?.spot.id != nil else { return }
            self?.savedStore.toggle(id: self?.spot.id ?? UUID())
        })
        spotDetailUserInfoCard.configure(handle: spot.posterHandle, lastCheckedIn: "4 days ago", isVerified: spot.verified, status: "local for 2 years", theme: theme)
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
        contentStack.addArrangedSubview(carousalCard)
        contentStack.addArrangedSubview(nameInfoCard)
        contentStack.addArrangedSubview(spotDetailDescriptionCard)
        contentStack.addArrangedSubview(spotDetailUserInfoCard)
        contentStack.axis = .vertical
        contentStack.spacing = 6
        
        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentStack.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            carousalCard.heightAnchor.constraint(equalToConstant: 280)
        ])
        
    }
}
