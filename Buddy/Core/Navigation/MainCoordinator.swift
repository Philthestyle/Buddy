import SwiftUI
import os.log

final class MainCoordinator: NavigationCoordinator, ObservableObject {
    enum Route: Hashable {
        case launch
        case home
        case profile(userId: String)
        case chat(matchId: String)
        case walkDetail(walkId: String)
    }
    
    @Published var path = NavigationPath()
    @Published var currentTab: Tab = .home
    @Inject private var toastManager: ToastManager
    
    private let logger = Logger(subsystem: "com.buddy", category: "Navigation")
    
    enum Tab: Int, CaseIterable {
        case home = 0
        case walks = 1
        case messages = 2
        case profile = 3
        
        var icon: String {
            switch self {
            case .home: return "house.fill"
            case .walks: return "map.fill"
            case .messages: return "message.fill"
            case .profile: return "person.fill"
            }
        }
        
        var title: String {
            switch self {
            case .home: return "Découvrir"
            case .walks: return "Balades"
            case .messages: return "Messages"
            case .profile: return "Profil"
            }
        }
    }
    
    func navigate(to route: Route) {
        Task { @MainActor in
            logger.info("Navigation: \(String(describing: route))")
            #if DEBUG
            toastManager.show("→ \(String(describing: route))", style: .info)
            #endif
            path.append(route)
        }
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
}
