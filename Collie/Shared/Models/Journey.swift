import Foundation

struct Journey: Identifiable, Codable {
    var id: String = UUID().uuidString
    var name: String
    var description: String
    var imageURL: URL
    var startDate: Date
}
