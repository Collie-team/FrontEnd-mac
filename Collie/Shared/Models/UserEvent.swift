import Foundation

struct UserEvent: Identifiable, Codable {
    var id: String {
        eventId
    }
    var eventId: String
    var journeyId: String
    var doneDate: TimeInterval?
}
