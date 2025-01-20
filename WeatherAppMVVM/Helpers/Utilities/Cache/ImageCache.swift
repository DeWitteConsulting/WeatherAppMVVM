
import SwiftUI

final class ImageCache {
    static let shared: ImageCache = .init()
    private let imageCache = MemoryCache<String, Image>()
    
    private init() { }
    
    @discardableResult
    func setImage(key url: String, with image: Image) -> Image {
        imageCache[url] = image
        return image
    }
    
    func getImage(key url: String) -> Image? {
        imageCache[url]
    }
}
