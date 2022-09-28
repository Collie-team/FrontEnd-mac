import Foundation

struct Journey: Identifiable, Codable {
    var id: String = UUID().uuidString
    var name: String
    var durationInDays: Int
    var description: String
    var imageURL: URL
    var usersIds: [String]
    var tasks: [Task]
    var managers: [User]
}
