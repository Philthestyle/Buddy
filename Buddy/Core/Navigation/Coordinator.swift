import SwiftUI

protocol Coordinator: AnyObject, ObservableObject {
    associatedtype Route
    func navigate(to route: Route)
    func pop()
    func popToRoot()
}

protocol NavigationCoordinator: Coordinator {}
