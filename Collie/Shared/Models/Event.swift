import Foundation

struct Event: Identifiable, Codable {
    var id: String = UUID().uuidString
    var journeyId: String
    var name: String
    var description: String
    var journeyId: String
    var contentLink: String
    var startDate: Date
    var endDate: Date
    var responsibleUserIds: [String]
    var category: TaskCategory?
}
