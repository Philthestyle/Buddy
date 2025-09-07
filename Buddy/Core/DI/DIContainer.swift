import Foundation

final class DIContainer {
    private var services: [String: Any] = [:]
    private var factories: [String: (DIContainer) -> Any] = [:]
    
    func register<T>(_ type: T.Type, factory: @escaping (DIContainer) -> T) {
        let key = String(describing: type)
        factories[key] = factory
    }
    
    func resolve<T>(_ type: T.Type) -> T? {
        let key = String(describing: type)
        
        if let service = services[key] as? T {
            return service
        }
        
        if let factory = factories[key] {
            let service = factory(self) as! T
            services[key] = service
            return service
        }
        
        return nil
    }
}
