import Foundation

struct TeamListUser: Identifiable {
    var id = UUID()
    
    var name: String
    var email: String
    var journey: String
    var progress: Float {
        return Float(self.doneTasks) / Float(self.totalTasks)
    }
    var totalTasks: Int
    var doneTasks: Int
}

final class TeamListViewModel: ObservableObject {
    private let teamListService = TeamSubscriptionService()
    @Published var newUserPopupEnabled = false
    @Published var teamListUsers: [TeamListUser] = []
    var teamUsers: [UserModel] = []
    var teamBusinessUsers: [BusinessUser] = []
    
    func fetchUsers(business: Business) {
        teamListService.fetchTeamInfo(business: business, authenticationToken: "TODO: COLOCAR TOKEN AQUI") { businessUsers, users in
            self.teamUsers = users
            self.teamBusinessUsers = businessUsers
        }
    }
    
    func processTeamList() {
        for (user, businessUser) in zip(self.teamUsers, self.teamBusinessUsers) {
//            let teamListUser = TeamListUser(name: user.name, email: user.email, journey: <#T##String#>, totalTasks: <#T##Int#>, doneTasks: <#T##Int#>)
        }
    }
    
    func registerUser(userToAdd: UserModel) {
//        databaseService.writeData(dataToWrite: userToAdd) { response in
//            if !response.isEmpty {
//                self.sampleUsers.append(userToAdd)
//            }
//        }
    }
}
