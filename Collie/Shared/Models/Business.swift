import Foundation

struct Business: Identifiable, Codable {
    var id: String = UUID().uuidString
    var name: String
    var description: String
    var journeys: [Journey]
    var usersIds: [String]
}
