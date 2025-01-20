
import SwiftUI

// MARK: - App Coordinator

final class AppCoordinator: Coodinator {
    @Published var navigationPath: NavigationPath = .init()
    
    private lazy var homeView: some View = {
        let weatherService = WeatherService()
        let viewModel = HomeViewModel(weatherService: weatherService)
        return HomeView(viewModel: viewModel)
    }()
    
    func start() {
        // Setup any initial configuration if needed
    }
    
    @ViewBuilder
    func buildView(for route: AppTransition) -> some View {
        switch route {
            case .showHome: homeView
        }
    }
}

// MARK: - App Router

extension AppCoordinator: AppRouter {
    func push(to route: AppTransition) {
        navigationPath.append(route)
    }
    
    func pop() {
        guard !navigationPath.isEmpty else { return }
        navigationPath.removeLast()
    }
}
