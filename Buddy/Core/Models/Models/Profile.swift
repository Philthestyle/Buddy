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
            bio: "Passionnée de randonnées avec mon fidèle compagnon. On adore explorer!",
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
            bio: "Mon chat et moi cherchons des compagnons de jeu pour des après-midis fun",
            imageURLs: [],
            pet: Pet(
                id: "p2",
                name: "Luna",
                type: .cat,
                breed: "Persan",
                age: 2
            ),
            location: Location(latitude: 48.8566, longitude: 2.3522, city: "Paris", distance: 5.0)
        ),
        Profile(
            id: "3",
            name: "Emma",
            age: 25,
            bio: "Amoureuse des animaux, je cherche des amis pour des balades au parc",
            imageURLs: [],
            pet: Pet(
                id: "p3",
                name: "Charlie",
                type: .dog,
                breed: "Beagle",
                age: 4
            ),
            location: Location(latitude: 48.8566, longitude: 2.3522, city: "Paris", distance: 3.0)
        ),
        Profile(
            id: "4",
            name: "Thomas",
            age: 30,
            bio: "Mon lapin et moi adorons rencontrer de nouvelles personnes",
            imageURLs: [],
            pet: Pet(
                id: "p4",
                name: "Coco",
                type: .rabbit,
                breed: "Nain",
                age: 1
            ),
            location: Location(latitude: 48.8566, longitude: 2.3522, city: "Paris", distance: 7.0)
        ),
        Profile(
            id: "5",
            name: "Marie",
            age: 27,
            bio: "Cherche des amis pour partager des moments avec nos animaux",
            imageURLs: [],
            pet: Pet(
                id: "p5",
                name: "Bella",
                type: .cat,
                breed: "Siamois",
                age: 3
            ),
            location: Location(latitude: 48.8566, longitude: 2.3522, city: "Paris", distance: 4.0)
        )
    ]
}
