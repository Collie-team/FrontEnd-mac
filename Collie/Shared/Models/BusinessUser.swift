import Foundation

enum BusinessUserRoles: String, Codable, CaseIterable {
    case admin = "Admin"
    case manager = "Gestor"
    case employee = "Colaborador"
}

struct BusinessUser: Codable {
    var userId: String
    var businessId: String
    var role: BusinessUserRoles
    var userTasks: [UserTask]
    var userJourneys: [UserJourney]
}
