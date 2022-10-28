import Foundation

struct Journey: Identifiable, Codable {
    var id: String = UUID().uuidString
    var name: String
    var description: String
    var imageURL: URL
    var startDate: Date
}

//struct Journey: Identifiable, Codable {
//    var id: String = UUID().uuidString
//    var name: String
//    var startDate: Date
//    var description: String
//    var imageURL: URL
//    var employees: [UserModel]
//    var tasks: [Task]
//    var events: [Event]
//    var managers: [UserModel]
//    
//}
