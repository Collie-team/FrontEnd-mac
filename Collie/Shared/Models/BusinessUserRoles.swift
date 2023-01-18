import Foundation

enum BusinessUserRoles: String, Codable, CaseIterable {
    case admin
    case manager
    case employee
    
    func getRoleText() -> String {
        switch self {
        case .admin:
            return "Administrador"
        case .manager:
            return "Gestor"
        case .employee:
            return "Colaborador"
        }
    }
}
