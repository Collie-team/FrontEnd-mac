import Foundation

enum BusinessUserRoles: String, Codable, CaseIterable {
    case admin
    case manager
    case employee
}

struct BusinessUser: Codable {
    var userId: String
    var businessId: String
    var role: BusinessUserRoles
    var userTasks: [UserTask]
    var userJourneys: [UserJourney]
}
