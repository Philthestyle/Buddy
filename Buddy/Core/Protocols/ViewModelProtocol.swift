import SwiftUI
import Combine

protocol ViewModelProtocol: ObservableObject {
    associatedtype DataType
    var state: DataState<DataType> { get set }
    func loadData() async
}
