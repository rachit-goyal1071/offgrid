import SwiftUI
import UIKit

class SpotDetailImageCarousel: UIView, UICollectionViewDelegate {
    
    private var images: [String] = []
    private let imageLoader = SharedImageLoader()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureDataSource()
        makeLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    nonisolated enum Section { case main }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Int>!
    
    private func configureDataSource() {
        
        let cellRegistration = UICollectionView.CellRegistration<CarouselImageCell, Int> { [weak self] cell, indexPath, identifier in
            guard let image = self?.images else { return }
            guard let self else { return }
            cell.configure(image: image[identifier], loader: self.imageLoader)
            
        }
        
        collectionView.isPagingEnabled = true
        
        dataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: collectionView) { collectionView, indexPath, id in
            collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration,
                for: indexPath,
                item: id
            )
            
        }
    }
    
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections([.main]);
        snapshot.appendItems(Array(images.indices))
        dataSource.apply(snapshot)
    }
    
    private func makeLayout() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        collectionView.delegate = self
    }
    
    func configure(theme: Theme, images: [String], createdAt: Date) {
        print(images)
        self.images = images
        applySnapshot()
    }
}

extension SpotDetailImageCarousel: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
}
