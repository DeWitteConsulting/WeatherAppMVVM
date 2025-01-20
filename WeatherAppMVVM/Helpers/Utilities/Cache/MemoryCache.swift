
import Foundation

final class MemoryCache<Key: Hashable, Value> {
    private let cache = NSCache<CacheKey, CacheValue>()
    
    // MARK: - Cache Value
    
    private final class CacheValue {
        let value: Value
        
        init(_ value: Value) {
            self.value = value
        }
    }
    
    // MARK: - Cache Key
    
    private final class CacheKey: NSObject {
        private let key: Key
        
        init(_ key: Key) {
            self.key = key
        }
        
        override func isEqual(_ object: Any?) -> Bool {
            guard let other = object as? CacheKey else {
                return false
            }
            return key == other.key
        }
        
        override var hash: Int { key.hashValue }
    }
    
    // MARK: - Subscript with key
    
    subscript(_ key: Key) -> Value? {
        get { cache.object(forKey: CacheKey(key))?.value }
        set {
            if let newValue {
                cache.setObject(
                    CacheValue(newValue),
                    forKey: CacheKey(key)
                )
            } else {
                cache.removeObject(forKey: CacheKey(key))
            }
        }
    }
}
