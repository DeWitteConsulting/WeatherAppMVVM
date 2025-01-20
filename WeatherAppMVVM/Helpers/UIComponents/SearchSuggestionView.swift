
import SwiftUI

struct SearchSuggestionView: View {
    private let suggestionState: SuggestionState
    private let completion: (Weather) -> Void
    
    init(_ suggestionState: SuggestionState,
         completion: @escaping (Weather) -> Void) {
        self.suggestionState = suggestionState
        self.completion = completion
    }
    
    // MARK: - Main View
    
    var body: some View {
        switch suggestionState {
            case .success(let weatherList):
                weatherListView(weatherList)
                
            case .empty:
                EmptyView()
                
            case .noResults(let searchText):
                ContentUnavailableView
                    .search(text: searchText)
                
            case .loading:
                ProgressView()
                    .controlSize(.extraLarge)
                    .frame(maxWidth: .infinity)
        }
    }
    
    // MARK: - UI Components
    
    private func weatherListView(_ weatherList: [Weather]) -> some View {
        ForEach(weatherList) { weather in
            WeatherSearchCardView(weather: weather)
                .onTapGesture {
                    completion(weather)
                }
        }
    }
}
