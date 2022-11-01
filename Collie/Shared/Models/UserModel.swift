import Foundation
import SwiftUI

struct UserModel: Identifiable, Codable, Hashable {
    var id: String = UUID().uuidString
    var name: String
    var email: String
    var jobDescription: String
    var personalDescription: String
    var imageURL: String
}
