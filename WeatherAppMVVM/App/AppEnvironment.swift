
import Foundation

enum AppEnvironment {
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()
    
    static var API_URL: URL {
        guard let urlString = AppEnvironment.infoDictionary["API_URL"] as? String,
              let apiURL = URL(string: urlString) else {
            fatalError("API URL is not set in plist for this environment")
        }
        return apiURL
    }
    
    static var API_KEY: String {
        guard let apiKey = AppEnvironment.infoDictionary["API_KEY"] as? String else {
            fatalError("API KEY is not set in plist for this environment")
        }
        return apiKey
    }
}
