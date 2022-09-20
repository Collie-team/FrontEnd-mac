import Foundation

struct Task: Identifiable, Codable {
    var id: String = UUID().uuidString
    var name: String
    var description: String
    var taskCategory: TaskCategory
}
