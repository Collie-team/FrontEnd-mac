import Foundation

struct BusinessUser: Codable {
    var userId: String
    var businessId: String
    var role: String
    var userTasks: [UserTask]
}
