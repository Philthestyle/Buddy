import Foundation

enum DataState<T> {
    case idle
    case loading
    case loaded(T)
    case failed(Error)
    
    var value: T? {
        if case .loaded(let data) = self {
            return data
        }
        return nil
    }
    
    var isLoading: Bool {
        if case .loading = self {
            return true
        }
        return false
    }
}
