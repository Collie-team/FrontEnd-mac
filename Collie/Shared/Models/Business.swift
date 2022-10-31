import Foundation

struct Business: Codable, Identifiable {
    var id: String = ""
    var name: String
    var description: String
    var journeys: [Journey]
    var userIds: [String]
}
