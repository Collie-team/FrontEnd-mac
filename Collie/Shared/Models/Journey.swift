import Foundation

struct Journey: Identifiable, Codable {
    var id: String = UUID().uuidString
    var name: String
    var durationInDays: Int
    var description: String
    var imageURL: String
    var usersIds: [String]
    var tasks: [Task]
    
}
