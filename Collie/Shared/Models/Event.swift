import Foundation

struct Event: Identifiable, Codable {
    var id: String = UUID().uuidString
    var name: String
    var description: String
    var link: String
    var startDate: Date
    var endDate: Date
    var responsibleEmployees: [UserModel]?
    var category: TaskCategory?
}
