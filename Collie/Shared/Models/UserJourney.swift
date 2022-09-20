import Foundation

struct UserJourney: Identifiable, Codable {
    var id: String = UUID().uuidString
    var journeyId: String
    var startDate: Date
    var endDate: Date
    var userTasks: [UserTask]
}
