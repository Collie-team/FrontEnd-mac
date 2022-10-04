import Foundation

struct Task: Identifiable, Codable {
    var id: String = UUID().uuidString
    var name: String
    var responsibleEmployees: [User]?
    var description: String
    var startDate: Date
    var endDate: Date
    var taskCategory: TaskCategory?
}
