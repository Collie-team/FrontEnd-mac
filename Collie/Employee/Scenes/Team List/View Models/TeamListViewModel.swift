import Foundation

final class TeamListViewModel: ObservableObject {
    @Published var newUserPopupEnabled = false
    @Published var sampleUsers: [User] = [
        User(name: "André Arns", email: "", jobDescription: "Desenvolvedor iOS", personalDescription: "", imageURL: "", businessId: "x"),
        User(name: "Ana Costa", email: "", jobDescription: "Designer", personalDescription: "", imageURL: "", businessId: "x"),
        User(name: "Raquel Zocoler", email: "", jobDescription: "Designer", personalDescription: "", imageURL: "", businessId: "x"),
        User(name: "Pablo Harbar", email: "", jobDescription: "Desenvolvedor iOS", personalDescription: "", imageURL: "", businessId: "x"),
        User(name: "Neidivaldo", email: "", jobDescription: "Designer", personalDescription: "", imageURL: "", businessId: "x")
    ]
    
    func fetchUsers() {
        let databaseService = DatabaseSubscriptionService<User>(route: .user)
        databaseService.fetchData() { userModels in
            self.sampleUsers = userModels
        }
    }
    
    func registerUser(userToAdd: User) {
        let databaseService = DatabaseSubscriptionService<User>(route: .user)
        databaseService.writeData(dataToWrite: userToAdd) { response in
            if !response.isEmpty {
                self.sampleUsers.append(userToAdd)
            }
        }
    }
}
