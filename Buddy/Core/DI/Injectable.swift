import Foundation

@propertyWrapper
struct Inject<T> {
    private var service: T
    
    init() {
        self.service = AppAssembly.shared.resolve(T.self)
    }
    
    var wrappedValue: T {
        get { service }
        mutating set { service = newValue }
    }
}
