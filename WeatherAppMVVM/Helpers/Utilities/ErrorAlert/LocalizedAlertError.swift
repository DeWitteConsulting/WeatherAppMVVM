
import SwiftUI

// MARK: - Localized Alert Error

struct LocalizedAlertError: LocalizedError {
    private let underlyingError: LocalizedError
    
    var errorDescription: String? {
        underlyingError.errorDescription
    }
    
    var recoverySuggestion: String? {
        underlyingError.recoverySuggestion
    }
    
    init?(error: Error?) {
        guard let localizedError = error as? LocalizedError else { return nil }
        self.underlyingError = localizedError
    }
}
