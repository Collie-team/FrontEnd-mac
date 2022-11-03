import Foundation

struct Task: Identifiable, Codable {
    var id: String = UUID().uuidString
    var journeyId: String
    var name: String
    var description: String
    var taskCategory: TaskCategory?
    var startDate: Date
    var endDate: Date
}
