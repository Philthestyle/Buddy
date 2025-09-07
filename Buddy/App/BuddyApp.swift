import SwiftUI

@main
struct BuddyApp: App {
    @StateObject private var coordinator = MainCoordinator()
    @StateObject private var toastManager = ToastManager()
    
    init() {
        AppAssembly.shared.registerDependencies()
        setupAppearance()
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                MainTabBarView()
                    .environmentObject(coordinator)
                    .environmentObject(toastManager)
                
                ToastOverlay()
                    .environmentObject(toastManager)
            }
        }
    }
    
    private func setupAppearance() {
        UITabBar.appearance().backgroundColor = UIColor.systemBackground
    }
}
