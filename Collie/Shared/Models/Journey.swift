import Foundation

struct Journey: Identifiable, Codable {
    var id: String = UUID().uuidString
    var name: String
    var startDate: Date
    var description: String
    var imageURL: URL
    var employees: [User]
    var tasks: [Task]
    var managers: [User]
}
