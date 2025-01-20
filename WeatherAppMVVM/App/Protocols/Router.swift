
import SwiftUI

// MARK: - Router

protocol Router {
    associatedtype Route
    
    var navigationPath: NavigationPath { get }
    
    func push(to route: Route)
    func pop()
}

// MARK: - Routers

protocol AppRouter: Router where Route == AppTransition { }
