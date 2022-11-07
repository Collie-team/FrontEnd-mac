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
    var currentBusiness: Business?
    
    func fetchUsers(business: Business) {
        currentBusiness = business
        teamListService.fetchTeamInfo(business: business, authenticationToken: "TODO: COLOCAR TOKEN AQUI") { businessUsers, users in
            self.teamUsers = users
            self.teamBusinessUsers = businessUsers
        }
    }
    
    func processTeamList(business: Business) {
        currentBusiness = business
        for (user, businessUser) in zip(self.teamUsers, self.teamBusinessUsers) {
            for userJourney in businessUser.userJourneys {
                let journey = business.journeys.first(where: {$0.id.description == userJourney.journeyId})
                let teamListUser = TeamListUser(name: user.name, email: user.email, journey: journey?.name ?? "", totalTasks: 9, doneTasks: 10)
                self.teamListUsers.append(teamListUser)
            }
        }
    }
    
    func inviteUser(userToAdd: UserModel, role: BusinessUserRoles) {
        let emailService = APISubscriptionService()
        emailService.sendInviteEmail(authenticationToken: "", business: currentBusiness!, email: userToAdd.email) {
            // Prompt success
        }
    }
}
