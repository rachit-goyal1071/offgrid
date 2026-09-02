import UIKit

class SharedImageLoader {
    
    let cache = NSCache<NSString, UIImage>()
    
    func cached(_ key: String) -> UIImage? {
        cache.object(forKey: key as NSString)
    }
    
    func load(_ urlString: String) async throws -> UIImage {
        
        let url = URL(string: urlString) ?? URL(string: "")!
        
        guard let image = cached(urlString) else {
            let val = try await URLSession.shared.data(from: url)
            let image = UIImage(data: val.0)!
            cache.setObject(image, forKey: urlString as NSString)
            return image
        }
        return image
    }
}
