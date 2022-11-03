import Foundation

struct Event: Identifiable, Codable {
    var id: String = UUID().uuidString
    var name: String
    var description: String
    var contentLink: String
    var startDate: Date
    var endDate: Date
    var responsibleUserIds: [String]
    var category: TaskCategory?
}
