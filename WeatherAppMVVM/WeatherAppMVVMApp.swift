
import SwiftUI

@main
struct WeatherAppMVVMApp: App {
    @StateObject private var appCoordinator: AppCoordinator = .init()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(appCoordinator)
        }
    }
}
