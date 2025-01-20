
import Foundation

enum HomeViewState {
    case success(Weather)
    case empty
    case loading
}

enum SuggestionState {
    case success([Weather])
    case noResults(String)
    case empty
    case loading
}
