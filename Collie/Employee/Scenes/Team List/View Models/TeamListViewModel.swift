import Foundation
import SwiftUI

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
            self.processTeamList()
        }
    }
    
    func processTeamList() {
        for (user, businessUser) in zip(self.teamUsers, self.teamBusinessUsers) {
            let userJourneys = currentBusiness!.journeys.filter({$0.userIds.contains(user.id)})
            let doneTasks = businessUser.userTasks.filter({$0.doneDate == nil})
            
            let teamListUser = TeamListUser(
                name: user.name,
                email: user.email,
                journey: userJourneys.count > 1 ? "\(userJourneys.first!.name) + \(userJourneys.count - 1)" : userJourneys.count > 0 ? userJourneys.first!.name : "Sem jornada",
                totalTasks: businessUser.userTasks.count,
                doneTasks: doneTasks.count)
            withAnimation() {
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
