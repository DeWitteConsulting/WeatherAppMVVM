
import SwiftUI

// MARK: - Coordinator

protocol Coodinator: ObservableObject {
    associatedtype Route
    associatedtype DestinationView: View
    
    func start()
    func buildView(for route: Route) -> DestinationView
}
