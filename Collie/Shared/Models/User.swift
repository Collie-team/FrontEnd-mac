import Foundation
import SwiftUI

struct User: Identifiable, Codable, Hashable {
    var id: String = UUID().uuidString
    var name: String
    var email: String
    var jobDescription: String
    var personalDescription: String
    var imageURL: String
    var businessId: String
}
