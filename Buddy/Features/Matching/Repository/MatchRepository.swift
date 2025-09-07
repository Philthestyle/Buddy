import Foundation

protocol MatchRepository {
    func fetchNearbyProfiles(mode: MatchMode) async -> [Profile]
    func processSwipe(profileId: String, action: SwipeAction) async
}

protocol UserRepository {
    func fetchUser(id: String) async -> Profile?
}

final class MockMatchRepository: MatchRepository {
    func fetchNearbyProfiles(mode: MatchMode) async -> [Profile] {
        try? await Task.sleep(nanoseconds: 500_000_000)
        return Profile.mockProfiles
    }
    
    func processSwipe(profileId: String, action: SwipeAction) async {
        try? await Task.sleep(nanoseconds: 200_000_000)
    }
}

final class MockUserRepository: UserRepository {
    func fetchUser(id: String) async -> Profile? {
        return Profile.mockProfiles.first
    }
}

final class RealMatchRepository: MatchRepository {
    private let network: NetworkService
    
    init(network: NetworkService) {
        self.network = network
    }
    
    func fetchNearbyProfiles(mode: MatchMode) async -> [Profile] {
        return []
    }
    
    func processSwipe(profileId: String, action: SwipeAction) async {
    }
}

final class RealUserRepository: UserRepository {
    private let network: NetworkService
    private let cache: CacheManager
    
    init(network: NetworkService, cache: CacheManager) {
        self.network = network
        self.cache = cache
    }
    
    func fetchUser(id: String) async -> Profile? {
        return nil
    }
}
