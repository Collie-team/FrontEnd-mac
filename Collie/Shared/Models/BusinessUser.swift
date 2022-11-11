import Foundation

struct BusinessUser: Codable {
    var userId: String
    var businessId: String
    var role: BusinessUserRoles
    var userTasks: [UserTask]
}
