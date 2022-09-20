import Foundation

struct User: Identifiable, Codable {
    var id: String = UUID().uuidString
    var name: String
    var email: String
    var jobDescription: String
    var personalDescription: String
    var imageURL: String
    var userJourneys: [UserJourney]
    var businessId: String
}
