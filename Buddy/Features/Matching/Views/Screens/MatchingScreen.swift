import SwiftUI

struct MatchingScreen: View {
    @StateObject private var viewModel = MatchingViewModel()
    @State private var currentMode: MatchMode = .friendship
    
    var body: some View {
        VStack(spacing: 0) {
            ModeToggleView(selectedMode: $currentMode)
                .padding()
            
            ZStack {
                if viewModel.state.isLoading {
                    ProgressView()
                } else if let profiles = viewModel.state.value {
                    ForEach(profiles.prefix(3)) { profile in
                        SwipeCardView(profile: profile)
                    }
                }
            }
            .padding()
            
            ActionButtonsView(
                onReject: { viewModel.swipeProfile(.reject) },
                onSuperLike: { viewModel.swipeProfile(.superLike) },
                onLike: { viewModel.swipeProfile(.like) }
            )
            .padding(.bottom)
        }
        .task {
            await viewModel.loadData()
        }
    }
}
