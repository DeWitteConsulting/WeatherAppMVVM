
import Foundation

final class URLRequestBuilder {
    static func build(from endpoint: Endpoint) throws -> URLRequest {
        guard let completeURL = buildCompleteURL(from: endpoint) else {
            throw NetworkError.invalidResponse
        }
        
        var request = URLRequest(url: completeURL)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.headers
        
        if let parameters = endpoint.parameters, endpoint.method != .get {
            try configureRequestBody(
                for: &request,
                parameters: parameters
            )
        }
        return request
    }
    
    private static func buildCompleteURL(from endpoint: Endpoint) -> URL? {
        let completeUrl = endpoint.baseURL.appendingPathComponent(endpoint.path)
        
        guard endpoint.method == .get,
              let parameters = endpoint.parameters else {
            return completeUrl
        }
        return buildQueryUrl(completeUrl, with: parameters)
    }
    
    private static func configureRequestBody(for request: inout URLRequest, parameters: Parameters) throws {
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
        } catch {
            throw NetworkError.encodingFailed
        }
    }
    
    private static func buildQueryUrl(_ url: URL, with parameters: Parameters) -> URL? {
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return nil }
        
        components.queryItems = parameters.map { key, value in
            URLQueryItem(name: key, value: "\(value)")
        }
        return components.url
    }
}
