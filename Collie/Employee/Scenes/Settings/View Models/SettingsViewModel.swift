import Foundation
import AppKit

final class SettingsViewModel: ObservableObject {
    
    struct Model: Hashable, Equatable {
        static func == (lhs: SettingsViewModel.Model, rhs: SettingsViewModel.Model) -> Bool { lhs.id == rhs.id }
        public func hash(into hasher: inout Hasher) { hasher.combine(id) }
        
        var id: String {
            userModel.id
        }
        var userModel: UserModel
        var businessUser: BusinessUser
    }
    
    private let teamSubscriptionService = TeamSubscriptionService()
    
    private let apiSubscriptionService = APISubscriptionService()
    
    @Published var userModelsList: [UserModel] = []
    
    @Published var businessUsersList: [BusinessUser] = []
    
    @Published var modelList: [Model] = []
    
    @Published var selectedOption: SettingsOptions
    @Published var selectedUserModel: UserModel?
    
    @Published var businessCode: String = "Carregando..."
    
    init() {
        selectedOption = .users
        bind()
    }
    
    func fetchUsers(business: Business) {
        teamSubscriptionService.fetchTeamInfo(business: business, authenticationToken: "") { businessUser, users in
            self.businessUsersList = businessUser
            self.userModelsList = users
            self.bind()
        }
    }
    
    func bind() {
        modelList = userModelsList.map { userModel in
            let businessUser = businessUsersList.first(where: {$0.userId == userModel.id})
            let listcomponent = Model(userModel: userModel, businessUser: businessUser!)
            return listcomponent
        }
    }
    
    func selectOption(_ option: SettingsOptions) {
        selectedOption = option
    }
    
    func selectUserModel(_ userModel: UserModel) {
        self.selectedUserModel = userModel
    }
    
    func unselectUserModel(_ userModel: UserModel) {
        self.selectedUserModel = nil
    }
    
    func isOptionSelected(_ option: SettingsOptions) -> Bool {
        selectedOption == option
    }
    
    func removeBusinessUser() {
        if let id = selectedUserModel?.id {
            let businessId = businessUsersList.first(where: {$0.userId == id})!.businessId
            businessUsersList.removeAll(where: { $0.userId == id })
            userModelsList.removeAll(where: { $0.id == id })
            modelList.removeAll(where: {$0.userModel.id == id})
            teamSubscriptionService.removeUserFromBusiness(authenticationToken: "", businessId: businessId, userId: id)
        }
    }
    
    func copyToClipboard(text: String) {
        let pasteBoard = NSPasteboard.general
        pasteBoard.clearContents()
        pasteBoard.writeObjects([text as NSString])
    }
    
    func fetchBusinessCode(businessId: String) {
        apiSubscriptionService.fetchBusinessCode(authenticationToken: "", businessId: businessId) { businessKey in
            self.businessCode = businessKey.code
        }
    }
    
    func redefineBusinessCode(businessId: String) {
        apiSubscriptionService.redefineBusinessCode(authenticationToken: "", businessId: businessId) { businessKey in
            self.businessCode = businessKey.code
        }
    }
}

enum SettingsOptions: String, CaseIterable {
    case general = "Geral"
    case users = "Usuários"
}
