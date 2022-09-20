import Foundation

struct TaskCategory: Identifiable, Codable {
    var id: String = UUID().uuidString
    var name: String
    var description: String
    var colorName: String
}
