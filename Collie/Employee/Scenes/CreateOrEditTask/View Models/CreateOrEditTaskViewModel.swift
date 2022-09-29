import Foundation

final class CreateOrEditTaskViewModel: ObservableObject {
    @Published var taskName = ""
    
    @Published var startDate = Date()
    
    @Published var endDate = Date()
    
    @Published var assignee: User?
    
    @Published var taskDescription = ""
    
    @Published var sampleUsers: [User] = [
        User(name: "André Arns", email: "", jobDescription: "Desenvolvedor iOS", personalDescription: "", imageURL: "", businessId: "x"),
        User(name: "Ana Costa", email: "", jobDescription: "Designer", personalDescription: "", imageURL: "", businessId: "x"),
        User(name: "Raquel Zocoler", email: "", jobDescription: "Designer", personalDescription: "", imageURL: "", businessId: "x"),
        User(name: "Pablo Harbar", email: "", jobDescription: "Desenvolvedor iOS", personalDescription: "", imageURL: "", businessId: "x"),
        User(name: "Neidivaldo", email: "", jobDescription: "Designer", personalDescription: "", imageURL: "", businessId: "x")
    ]
    
    @Published var showUserList = false
    
    func isButtonDisabled() -> Bool {
        taskName.isEmpty
    }
}
