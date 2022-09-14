import Foundation

struct Journey: Identifiable {
    var id: String = UUID().uuidString
    var title: String
    var subtitle: String
    var imageName: String
}
