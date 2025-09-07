import SwiftUI
import Combine

@MainActor
final class MatchingViewModel: ViewModelProtocol {
    @Published var state: DataState<[Profile]> = .idle
    @Published var currentProfile: Profile?
    @Published var mode: MatchMode = .friendship
    
    @Inject private var repository: MatchRepository
    @Inject private var cache: CacheManager
    @Inject private var toastManager: ToastManager
    
    func loadData() async {
        state = .loading
        
        let profiles = await repository.fetchNearbyProfiles(mode: mode)
        await cache.store(profiles, key: "profiles_\(mode.rawValue)")
        state = .loaded(profiles)
        currentProfile = profiles.first
    }
    
    func swipeProfile(_ action: SwipeAction) {
        guard let profile = currentProfile else { return }
        
        Task {
            await repository.processSwipe(profileId: profile.id, action: action)
            
            if case .loaded(var profiles) = state {
                profiles.removeFirst()
                state = .loaded(profiles)
                currentProfile = profiles.first
                
                switch action {
                case .like:
                    toastManager.show("❤️ Like!", style: .success)
                case .superLike:
                    toastManager.show("⭐ Super!", style: .success)
                case .reject:
                    break
                }
            }
        }
    }
}

enum SwipeAction {
    case reject, like, superLike
}
