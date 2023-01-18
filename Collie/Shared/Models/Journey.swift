import Foundation

struct Journey: Identifiable, Codable, Hashable {
    var id: String = UUID().uuidString
    var name: String
    var description: String
    var imageURL: String
    var startDate: Date
    var userIds: [String]
}
