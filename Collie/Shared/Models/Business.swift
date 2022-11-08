import Foundation

struct Business: Codable, Identifiable, Equatable {
    static func == (lhs: Business, rhs: Business) -> Bool {
        lhs.id == rhs.id
    }
    
    var id: String = ""
    var name: String
    var description: String
    var journeys: [Journey]
    var tasks: [Task]
    var events: [Event]
    var imageURL: String?
}
