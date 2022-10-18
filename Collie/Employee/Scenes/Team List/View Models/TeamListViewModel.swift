import Foundation

final class TeamListViewModel: ObservableObject {
    private let databaseService = DatabaseSubscriptionService<UserModel>(route: .user)
    @Published var newUserPopupEnabled = false
    @Published var sampleUsers: [UserModel] = [
        UserModel(name: "André Arns", email: "", jobDescription: "Desenvolvedor iOS", personalDescription: "", imageURL: "", businessId: "x"),
        UserModel(name: "Ana Costa", email: "", jobDescription: "Designer", personalDescription: "", imageURL: "", businessId: "x"),
        UserModel(name: "Raquel Zocoler", email: "", jobDescription: "Designer", personalDescription: "", imageURL: "", businessId: "x"),
        UserModel(name: "Pablo Harbar", email: "", jobDescription: "Desenvolvedor iOS", personalDescription: "", imageURL: "", businessId: "x"),
        UserModel(name: "Neidivaldo", email: "", jobDescription: "Designer", personalDescription: "", imageURL: "", businessId: "x")
    ]
    
    func fetchUsers() {
//        databaseService.fetchData() { userModels in
//            self.sampleUsers = userModels
//        }
    }
    
    func registerUser(userToAdd: UserModel) {
//        databaseService.writeData(dataToWrite: userToAdd) { response in
//            if !response.isEmpty {
//                self.sampleUsers.append(userToAdd)
//            }
//        }
    }
}
