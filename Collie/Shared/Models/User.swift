import Foundation

struct User: Identifiable, Codable, QueryParameterable {
struct User: Identifiable, Codable, Hashable {
    var id: String = UUID().uuidString
    var name: String
    var email: String
    var jobDescription: String
    var personalDescription: String
    var imageURL: String
    var businessId: String
    
    func createQueryParameters() -> String {
        var query = "?"
        query += "name=" + self.name + "&"
        query += "email=" + self.email + "&"
        query += "jobDescription=" + self.jobDescription + "&"
        query += "personalDescription=" + self.personalDescription + "&"
        query += "imageURL=" + self.imageURL + "&"
        query += "businessId=" + self.businessId

        return query
    }
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case email = "email"
        case jobDescription = "jobDescription"
        case personalDescription = "personalDescription"
        case imageURL = "imageURL"
        case businessId = "businessId"
    }
}
