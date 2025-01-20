import SwiftUI

struct HomeView<ViewModel: HomeViewModelProtocol>: View {
    @ObservedObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Main View
    
    var body: some View {
        VStack {
            switch viewModel.viewState {
                case .success(let weather):
                    CityWeatherContent(weather: weather)
                    
                case .loading:
                    ProgressView()
                        .controlSize(.extraLarge)
                    
                case .empty:
                    emptyStateView
            }
        }
        .errorAlert(error: $viewModel.underlyingError)
        .frame(maxHeight: .infinity)
        .keyboardType(.twitter)
        .toolbarTitleDisplayMode(.inline)
        .searchable(text: $viewModel.searchText, isPresented: $viewModel.isSearchFocused)
        .searchSuggestions {
            SearchSuggestionView(viewModel.suggestionState) { weather in
                viewModel.updateLocation(with: weather)
            }
        }
    }
    
    // MARK: - UI Components
    
    private var emptyStateView: some View {
        ContentUnavailableView(
            "No City Selected",
            systemImage: "network.slash",
            description: Text("Please Search For a City")
        )
    }
}
