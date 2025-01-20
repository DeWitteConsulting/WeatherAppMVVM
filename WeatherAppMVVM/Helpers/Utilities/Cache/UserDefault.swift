
import Foundation

@propertyWrapper
struct UserDefault<Value> {
    private let key: String
    private let container: UserDefaults
    
    init(key: String, container: UserDefaults = .standard) {
        self.key = key
        self.container = container
    }

    var wrappedValue: Value? {
        get {
            container.object(forKey: key) as? Value
        }
        set {
            if let value = newValue {
                container.set(value, forKey: key)
            } else {
                container.removeObject(forKey: key)
            }
        }
    }
}
