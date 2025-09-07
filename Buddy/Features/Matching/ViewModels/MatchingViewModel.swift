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
    
    private var allProfiles: [Profile] = []
    
    func loadData() async {
        state = .loading
        
        let profiles = await repository.fetchNearbyProfiles(mode: mode)
        await cache.store(profiles, key: "profiles_\(mode.rawValue)")
        
        allProfiles = profiles
        state = .loaded(profiles)
        currentProfile = profiles.first
    }
    
    func handleSwipe(_ action: SwipeAction, for profile: Profile?) {
        guard let profile = profile else { return }
        
        // Remove swiped profile
        if case .loaded(var profiles) = state {
            profiles.removeAll { $0.id == profile.id }
            state = .loaded(profiles)
            currentProfile = profiles.first
            
            // Show feedback
            switch action {
            case .like:
                toastManager.show("❤️ Match potentiel !", style: .success)
            case .superLike:
                toastManager.show("⭐ Super Like envoyé !", style: .success)
            case .reject:
                break
            }
            
            // Process in background
            Task {
                await repository.processSwipe(profileId: profile.id, action: action)
            }
            
            // Reload if empty
            if profiles.isEmpty {
                Task {
                    await loadData()
                }
            }
        }
    }
    
    func swipeProfile(_ action: SwipeAction) {
        handleSwipe(action, for: currentProfile)
    }
}
