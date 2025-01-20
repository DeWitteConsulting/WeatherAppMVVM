import Foundation

enum NetworkError {
    case invalidResponse
    case decodingFailed
    case encodingFailed
    case clientError
    case serverError
    case unknownError
}

// MARK: - Localized Error

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidResponse: "Oops! Something went wrong."
        case .decodingFailed: "Data Processing Error"
        case .encodingFailed: "Request Preparation Error"
        case .clientError:  "Connection Issue"
        case .serverError: "Server Issue"
        case .unknownError: "Unexpected Error"
        }
    }

    var recoverySuggestion: String? {
        switch self {
        case .invalidResponse: "The server sent an unexpected response. Please check your connection and try again."
        case .decodingFailed: "We couldn’t process the data correctly. Please report this issue to our support team."
        case .encodingFailed: "We couldn’t prepare your request. Please try again."
        case .clientError: "There seems to be an issue with your request. Please verify and try again."
        case .serverError: "The server is having trouble right now. Please try again later."
        case .unknownError: "An unexpected issue occurred. Please contact support for assistance."
        }
    }
}
