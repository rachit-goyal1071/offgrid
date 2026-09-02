import UIKit

class CarouselImageCell: UICollectionViewCell {
    
    private let imageView = UIImageView()
    private var loadTask: Task<Void, Never>?
    private var currentUrl: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setup() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(image: String, loader: SharedImageLoader) {
        currentUrl = image
        if let img = loader.cached(image) {
            imageView.image = img
            return
        }
        loadTask = Task { [weak self] in
            let img = try? await loader.load(image)
            guard self?.currentUrl == image else { return }
            self?.imageView.image = img
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        loadTask?.cancel()
        imageView.image = nil
    }
}
