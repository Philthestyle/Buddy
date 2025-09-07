import Foundation

@propertyWrapper
struct Inject<T> {
    private let service: T
    
    init() {
        // Solution 1: Force l'accès synchrone au MainActor
        self.service = MainActor.assumeIsolated {
            AppAssembly.shared.resolve(T.self)
        }
    }
    
    var wrappedValue: T {
        get { service }
    }
}
