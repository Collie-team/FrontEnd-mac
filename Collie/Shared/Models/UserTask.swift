import Foundation

struct UserTask: Identifiable, Codable {
    var id: String = UUID().uuidString
    var taskId: String
    var journeyId: String
    var doneDate: Date?
}
