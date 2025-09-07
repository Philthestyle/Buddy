import SwiftUI

struct MainTabBarView: View {
    @EnvironmentObject var coordinator: MainCoordinator
    @State private var showLaunchScreen = true
    
    var body: some View {
        Group {
            if showLaunchScreen {
                LaunchScreen()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            withAnimation {
                                showLaunchScreen = false
                            }
                        }
                    }
            } else {
                TabView(selection: $coordinator.currentTab) {
                    ForEach(MainCoordinator.Tab.allCases, id: \.self) { tab in
                        tabContent(for: tab)
                            .tabItem {
                                Label(tab.title, systemImage: tab.icon)
                            }
                            .tag(tab)
                    }
                }
                .accentColor(Theme.Colors.primary)
            }
        }
    }
    
    @ViewBuilder
    private func tabContent(for tab: MainCoordinator.Tab) -> some View {
        NavigationStack(path: $coordinator.path) {
            switch tab {
            case .home:
                MatchingScreen()
            case .walks:
                WalksScreen()
            case .messages:
                MessagesListScreen()
            case .profile:
                ProfileScreen()
            }
        }
    }
}
