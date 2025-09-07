import Foundation

@MainActor
final class AppAssembly {
    static let shared = AppAssembly()
    private var container = DIContainer()
    
    private init() {}
    
    func registerDependencies() {
        container.register(NetworkService.self) { _ in
            NetworkManager(configuration: .default)
        }
        
        container.register(CacheManager.self) { _ in
            CacheManager(storage: .memory)
        }
        
        container.register(ToastManager.self) { _ in
            ToastManager()
        }
        
        container.register(NavigationCoordinator.self) { _ in
            MainCoordinator()
        }
        
        #if DEBUG
        container.register(UserRepository.self) { _ in
            MockUserRepository()
        }
        container.register(MatchRepository.self) { _ in
            MockMatchRepository()
        }
        #else
        container.register(UserRepository.self) { resolver in
            RealUserRepository(
                network: resolver.resolve(NetworkService.self)!,
                cache: resolver.resolve(CacheManager.self)!
            )
        }
        container.register(MatchRepository.self) { resolver in
            RealMatchRepository(
                network: resolver.resolve(NetworkService.self)!
            )
        }
        #endif
    }
    
    func resolve<T>(_ type: T.Type) -> T {
        return container.resolve(type)!
    }
}
