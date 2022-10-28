import Foundation

struct Business: Codable, Identifiable {
    var id: String = ""
    var name: String
    var description: String
    var journeys: [Journey]
    var tasks: [Task]
//    var userIds: [String]
    var events: [Event]
    var imageURL: String?
}
