import Foundation

struct Pet: Identifiable, Codable, Hashable {
    let id: String
    let name: String
    let type: PetType
    let breed: String
    let age: Int
    
    enum PetType: String, Codable, CaseIterable {
        case dog = "dog"
        case cat = "cat"
        case bird = "bird"
        case rabbit = "rabbit"
        case other = "other"
        
        var emoji: String {
            switch self {
            case .dog: return "🐕"
            case .cat: return "🐱"
            case .bird: return "🦜"
            case .rabbit: return "🐰"
            case .other: return "🐾"
            }
        }
    }
}
