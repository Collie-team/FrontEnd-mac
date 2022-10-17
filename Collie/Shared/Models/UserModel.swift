import Foundation
import SwiftUI

struct UserModel: Identifiable, Codable, Hashable {
    var id: String = UUID().uuidString
    var name: String
    var email: String
    var jobDescription: String
    var personalDescription: String
    var imageURL: String
    var businessId: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case email = "email"
        case jobDescription = "jobDescription"
        case personalDescription = "personalDescription"
        case imageURL = "imageURL"
        case businessId = "businessId"
    }
}
