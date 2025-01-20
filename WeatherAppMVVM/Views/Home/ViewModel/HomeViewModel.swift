import Combine
import Foundation

final class HomeViewModel: HomeViewModelProtocol {
    @Published var searchText: String = ""
    @Published var isSearchFocused: Bool = false
    @Published var underlyingError: Error?
    
    @Published private(set) var viewState: HomeViewState = .loading
    @Published private(set) var suggestionState: SuggestionState = .empty
    
    // MARK: - Private Properties
    
    @UserDefault(key: "lastKnownCoordinates")
    private var lastKnownCoordinates: String?
    
    private var searchCancellable: AnyCancellable?
    private let weatherService: WeatherFetching
    private let debounceDuration: TimeInterval
    
    // MARK: - Initializer
    
    init(weatherService: WeatherFetching,
         debounceDuration: TimeInterval = 0.3) {
        self.weatherService = weatherService
        self.debounceDuration = debounceDuration
        bindSearchText()
        loadWeatherForLastKnownLocation()
    }
    
    // MARK: - Public Methods
    
    func updateLocation(with weather: Weather) {
        let coordinates = "\(weather.location.lat),\(weather.location.lon)"
        lastKnownCoordinates = coordinates
        resetSearchState()
        viewState = .success(weather)
    }
    
    // MARK: - Private Methods
    
    private func bindSearchText() {
        searchCancellable = $searchText
            .debounce(for: .seconds(debounceDuration), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] query in
                self?.performCitySearch(query: query)
            }
    }
    
    private func loadWeatherForLastKnownLocation() {
        viewState = .loading
        
        guard let coordinates = lastKnownCoordinates else {
            viewState = .empty
            return
        }
        fetchWeatherForCoordinates(coordinates)
    }
    
    private func fetchWeatherForCoordinates(_ coordinates: String) {
        Task { @MainActor in
            do {
                let weather = try await weatherService.fetchCurrentWeather(for: coordinates)
                viewState = .success(weather)
            } catch {
                handleError(error)
            }
        }
    }
    
    private func performCitySearch(query: String) {
        suggestionState = .loading
        
        guard !query.isEmpty else {
            suggestionState = .empty
            return
        }
        
        Task { @MainActor in
            do {
                let cities = try await weatherService.searchCities(for: query)
                let weatherList = try await weatherService.fetchWeatherList(for: cities)
                
                suggestionState = weatherList.isEmpty
                ? .noResults(searchText)
                : .success(weatherList)
            } catch {
                handleError(error)
            }
        }
    }
    
    private func resetSearchState() {
        searchText = ""
        isSearchFocused = false
    }
    
    private func handleError(_ error: Error) {
        debugPrint("Error: \(error.localizedDescription)")
        underlyingError = error
    }
}
