import SwiftUI

struct MatchingScreen: View {
    @StateObject private var viewModel = MatchingViewModel()
    @State private var currentMode: MatchMode = .friendship
    
    var body: some View {
        VStack(spacing: 0) {
            // Mode Toggle
            ModeToggleView(selectedMode: $currentMode)
                .padding()
                .onChange(of: currentMode) { newMode in
                    viewModel.mode = newMode
                    Task {
                        await viewModel.loadData()
                    }
                }
            
            // Cards Stack
            ZStack {
                if viewModel.state.isLoading {
                    ProgressView()
                        .scaleEffect(1.5)
                } else if let profiles = viewModel.state.value, !profiles.isEmpty {
                    ForEach(profiles.indices.reversed(), id: \.self) { index in
                        if index < 3 {
                            SwipeCardView(
                                profile: profiles[index],
                                onSwipe: { action in
                                    viewModel.handleSwipe(action, for: profiles[index])
                                }
                            )
                            .zIndex(Double(profiles.count - index))
                            .offset(y: CGFloat(index * 5))
                            .scaleEffect(1.0 - CGFloat(index) * 0.02)
                        }
                    }
                } else {
                    EmptyStateView()
                }
            }
            .padding()
            
            // Action Buttons
            ActionButtonsView(
                onReject: { viewModel.handleSwipe(.reject, for: viewModel.currentProfile) },
                onSuperLike: { viewModel.handleSwipe(.superLike, for: viewModel.currentProfile) },
                onLike: { viewModel.handleSwipe(.like, for: viewModel.currentProfile) }
            )
            .padding(.bottom, 20)
        }
        .background(Theme.Colors.background)
        .task {
            await viewModel.loadData()
        }
    }
}

struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("🐾")
                .font(.system(size: 80))
            
            Text("Plus de profils disponibles")
                .font(.title2)
                .fontWeight(.bold)
            
            Text("Revenez plus tard pour découvrir de nouveaux amis")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}
