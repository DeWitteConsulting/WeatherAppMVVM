
import Foundation

final class CurrentWeatherEndpoint: Endpoint {
    private let query: String
    
    let baseURL: URL = AppEnvironment.API_URL
    
    let path: String = "/current.json"
    
    let method: HTTPMethod = .get
    
    let headers: [String: String]? = nil
    
    var parameters: Parameters? {
        [
            "key": AppEnvironment.API_KEY,
            "q": query
        ]
    }
    
    init(query: String) {
        self.query = query
    }
}
