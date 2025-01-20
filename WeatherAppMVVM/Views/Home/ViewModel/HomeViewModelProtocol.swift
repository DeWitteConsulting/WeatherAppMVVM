
import Foundation

protocol HomeViewModelProtocol: ObservableObject {
    var searchText: String { get set }
    var isSearchFocused: Bool { get set }
    var underlyingError: Error? { get set }
    var suggestionState: SuggestionState { get }
    var viewState: HomeViewState { get }

    func updateLocation(with weather: Weather)
}
