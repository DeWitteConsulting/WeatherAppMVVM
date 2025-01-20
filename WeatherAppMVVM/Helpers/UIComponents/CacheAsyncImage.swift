
import SwiftUI

struct CacheAsyncImage: View {
    private let url: String
    private let imageCache: ImageCache = .shared
    
    private var imageURL: URL? {
        URL(string: url.starts(with: "https:") ? url : "https:\(url)")
    }
    
    // MARK: - Initializer
    
    init(url: String) {
        self.url = url
    }
    
    // MARK: - Main View
    
    var body: some View {
        if let cachedImage = imageCache.getImage(key: url) {
            cachedImage
                .resizable()
                .interpolation(.high)
                .scaledToFit()
        } else if let imageURL {
            imageLoaded(from: imageURL)
        } else {
            invalidURLView
        }
    }
    
    // MARK: - UI Components
    
    private func imageLoaded(from imageURL: URL) -> some View {
        AsyncImage(url: imageURL) { phase in
            switch phase {
                case .success(let image):
                    imageCache
                        .setImage(key: url, with: image)
                        .resizable()
                        .interpolation(.high)
                        .scaledToFit()
                    
                case .failure: placeholderView
                default: ProgressView()
            }
        }
    }
    
    private var placeholderView: some View {
        Text("Failed to load image")
            .foregroundColor(.gray)
            .font(.caption)
    }
    
    private var invalidURLView: some View {
        Text("Invalid URL")
            .foregroundColor(.red)
            .font(.caption)
    }
}
