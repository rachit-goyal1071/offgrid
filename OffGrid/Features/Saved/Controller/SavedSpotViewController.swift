import UIKit
import SwiftUI
import Combine

class SavedSpotViewController: UIViewController {
    
    private var theme: Theme
    private var spots: [Spot] = []
    private var vm: SavedSpotViewModel
    private var cancellables = Set<AnyCancellable>()
    
    nonisolated enum Section { case main }
    
    init(theme: Theme, vm: SavedSpotViewModel) {
        self.theme = theme
        self.vm = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(theme.bgBase)
        setupHierarchy()
        configureDataSource()
        
        vm.$state.sink { [weak self] state in
            self?.render(state)
        }.store(in: &cancellables)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task {
            await vm.load()
        }
    }
    
    private func render(_ state: SavedSpotViewModel.State) {
        switch state {
        case .loading:
            spinner.startAnimating()
        case .loaded(let spots):
            spinner.stopAnimating()
            self.spots = spots; applySnapshot()
        case .empty:
            spinner.stopAnimating()
            self.spots = []; applySnapshot()
        case .failed:
            spinner.stopAnimating()
        }
    }
    
    private func setupHierarchy() {
        
        view.addSubview(pageTitle)
        NSLayoutConstraint.activate([
            pageTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            pageTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
        ])
        
        view.addSubview(spinner)
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(96))
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, UUID>!
    
    private func configureDataSource() {
        
        let cellRegistration = UICollectionView.CellRegistration<SpotCell, UUID> { [weak self] cell, _, id in
            guard let spot = self?.spots.first(where: { $0.id == id }) else { return }
            cell.configure(spot: spot, theme: self?.theme ?? Theme())
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, UUID>(collectionView: collectionView) { collectionView, indexPath, id in
            collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration,
                for: indexPath,
                item: id
            )
        }
    }
    
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: makeLayout())
        cv.backgroundColor = .clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self
        return cv
    }()
    
    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.color = UIColor(theme.accentNeon)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    private lazy var pageTitle: UILabel = {
        let label = UILabel()
        label.font = .titleS
        label.textColor = UIColor(theme.textPrimary)
        label.text = "saved"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func makeLayout() -> UICollectionViewLayout {
        let item = NSCollectionLayoutItem(layoutSize: size)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: size, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, UUID>()
        snapshot.appendSections([.main]);
        snapshot.appendItems(spots.map(\.id))
        dataSource.apply(snapshot)
    }
}

extension SavedSpotViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                         contextMenuConfigurationForItemAt indexPath: IndexPath,
                         point: CGPoint) -> UIContextMenuConfiguration? {
        guard let id = dataSource.itemIdentifier(for: indexPath) else { return nil }
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { [weak self] _ in
            let unsave = UIAction(title: "unsave",
                                  image: UIImage(systemName: "bookmark.slash"),
                                  attributes: .destructive) { _ in
                Task { await self?.vm.unsave(id: id) }
            }
            return UIMenu(children: [unsave])
        }
    }
}
