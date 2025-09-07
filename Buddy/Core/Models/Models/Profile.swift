import Foundation

struct Profile: Identifiable, Codable, Hashable {
    let id: String
    let name: String
    let age: Int
    let bio: String
    let imageURLs: [String]
    let pet: Pet
    let location: Location?
    
    struct Location: Codable, Hashable {
        let latitude: Double
        let longitude: Double
        let city: String
        let distance: Double?
    }
}

enum MatchMode: String, Codable, CaseIterable {
    case friendship = "friendship"
    case love = "love"
    
    var displayName: String {
        switch self {
        case .friendship: return "Amitié"
        case .love: return "Amour"
        }
    }
    
    var icon: String {
        switch self {
        case .friendship: return "🐾"
        case .love: return "❤️"
        }
    }
}

extension Profile {
    static let mockProfiles: [Profile] = [
        Profile(
            id: "1",
            name: "Sophie",
            age: 28,
            bio: "Passionnée de randonnées avec mon fidèle compagnon",
            imageURLs: [],
            pet: Pet(
                id: "p1",
                name: "Max",
                type: .dog,
                breed: "Golden Retriever",
                age: 3
            ),
            location: Location(latitude: 48.8566, longitude: 2.3522, city: "Paris", distance: 2.5)
        ),
        Profile(
            id: "2",
            name: "Lucas",
            age: 32,
            bio: "Mon chat et moi cherchons des compagnons de jeu",
            imageURLs: [],
            pet: Pet(
                id: "p2",
                name: "Luna",
                type: .cat,
                breed: "Persan",
                age: 2
            ),
            location: Location(latitude: 48.8566, longitude: 2.3522, city: "Paris", distance: 5.0)
        )
    ]
}
