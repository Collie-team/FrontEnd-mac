import Foundation

enum BusinessUserRoles: String, Codable, CaseIterable {
//    case admin = "Admin"
//    case manager = "Gestor"
//    case employee = "Colaborador"
    case admin
    case manager
    case employee
    
//    private enum CodingKeys: String, CodingKey {
//        case admin = "admin"
//        case manager = "manager"
//        case employee = "employee"
//    }
}

struct BusinessUser: Codable {
    var userId: String
    var businessId: String
    var role: BusinessUserRoles
    var userTasks: [UserTask]
}
