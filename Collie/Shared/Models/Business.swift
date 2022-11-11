import Foundation

struct Business: Codable, Identifiable {
    var id: String = ""
    var name: String
    var description: String
    var journeys: [Journey]
    var tasks: [Task]
    var categories: [TaskCategory]
    var events: [Event]
    var imageURL: String?
}

extension Business: Equatable {
    static func == (lhs: Business, rhs: Business) -> Bool {
        lhs.id == rhs.id
    }
}

extension Business: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
