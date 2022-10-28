import Foundation
import SwiftUI

struct UserModel: Identifiable, Codable, Hashable {
    var id: String = UUID().uuidString
    var name: String
    var email: String
    var jobDescription: String
    var personalDescription: String
    var imageURL: String
    
//    private enum CodingKeys: String, CodingKey {
//        case id = "id"
//        case name = "name"
//        case email = "email"
//        case jobDescription = "jobDescription"
//        case personalDescription = "personalDescription"
//        case imageURL = "imageURL"
//    }
}
