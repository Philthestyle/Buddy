import Foundation

actor CacheManager {
    enum Storage {
        case memory
        case disk
        case coreData
    }
    
    private var memoryCache: [String: Any] = [:]
    private let storage: Storage
    
    init(storage: Storage = .memory) {
        self.storage = storage
    }
    
    func store<T: Codable>(_ object: T, key: String) async {
        switch storage {
        case .memory:
            memoryCache[key] = object
        case .disk:
            if let data = try? JSONEncoder().encode(object) {
                UserDefaults.standard.set(data, forKey: key)
            }
        case .coreData:
            break
        }
    }
    
    func get<T: Codable>(_ key: String, type: T.Type) async -> T? {
        switch storage {
        case .memory:
            return memoryCache[key] as? T
        case .disk:
            guard let data = UserDefaults.standard.data(forKey: key) else { return nil }
            return try? JSONDecoder().decode(T.self, from: data)
        case .coreData:
            return nil
        }
    }
    
    func clear() async {
        memoryCache.removeAll()
    }
}
