
import Foundation

protocol Endpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var parameters: Parameters? { get }
}

// MARK: - Parameters Typealias

typealias Parameters = [String: Any]
