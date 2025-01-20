
import Foundation

protocol WeatherFetching {
    func fetchCurrentWeather(for coordinates: String) async throws -> Weather
    func searchCities(for query: String) async throws -> [CitySearchResult]
    func fetchWeatherList(for cities: [CitySearchResult]) async throws -> [Weather]
}

final class WeatherService: WeatherFetching {
    private let networkManager: NetworkManaging

    init(networkManager: NetworkManaging = NetworkManager.shared) {
        self.networkManager = networkManager
    }

    func fetchCurrentWeather(for coordinates: String) async throws -> Weather {
        let endpoint = CurrentWeatherEndpoint(query: coordinates)
        return try await networkManager.performRequest(from: endpoint)
    }

    func searchCities(for query: String) async throws -> [CitySearchResult] {
        let endpoint = CitySearchEndpoint(query: query)
        return try await networkManager.performRequest(from: endpoint)
    }

    func fetchWeatherList(for cities: [CitySearchResult]) async throws -> [Weather] {
        try await withThrowingTaskGroup(of: Weather.self) { taskGroup in
            for city in cities {
                taskGroup.addTask { [unowned self] in
                    let coordinates = "\(city.lat),\(city.lon)"
                    return try await fetchCurrentWeather(for: coordinates)
                }
            }
            return try await taskGroup.reduce(into: []) { $0.append($1) }
        }
    }
}
