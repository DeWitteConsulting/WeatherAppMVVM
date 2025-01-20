
import Foundation

protocol NetworkManaging {
    func performRequest<T: Decodable>(from endpoint: Endpoint) async throws -> T
}

final class NetworkManager: NetworkManaging {
    static let shared = NetworkManager()
    
    private let session: URLSession
    private let decoder: JSONDecoder
    
    // MARK: - Initializer
    
    init(session: URLSession = .shared,
         decoder: JSONDecoder = .init()) {
        self.session = session
        self.decoder = decoder
    }
    
    // MARK: - Public Methods
    
    func performRequest<T: Decodable>(from endpoint: Endpoint) async throws -> T {
        let request = try URLRequestBuilder.build(from: endpoint)
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        try validateResponse(httpResponse)
        return try decodeData(data)
    }
    
    // MARK: - Private Methods
    
    private func validateResponse(_ response: HTTPURLResponse) throws {
        switch response.statusCode {
            case 200...299: return
            case 400...499: throw NetworkError.clientError
            case 500...599: throw NetworkError.serverError
            default: throw NetworkError.unknownError
        }
    }
    
    private func decodeData<T: Decodable>(_ data: Data) throws -> T {
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingFailed
        }
    }
}
