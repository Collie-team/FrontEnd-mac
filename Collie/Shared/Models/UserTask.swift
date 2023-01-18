import Foundation

struct UserTask: Identifiable, Codable {
    var id: String {
        taskId
    }
    var taskId: String
    var journeyId: String
    var doneDate: TimeInterval?
}
