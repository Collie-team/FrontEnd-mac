import Foundation

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
    
    @Published var userModelsList: [UserModel] = [
        UserModel(id: "001", name: "André", email: "andreluisarns@gmail.com", jobDescription: "Dev iOS", personalDescription: "", imageURL: ""),
        UserModel(id: "002", name: "Pablo", email: "andreluisarns@gmail.com", jobDescription: "Dev iOS", personalDescription: "", imageURL: ""),
        UserModel(id: "003", name: "Ana", email: "andreluisarns@gmail.com", jobDescription: "Dev iOS", personalDescription: "", imageURL: ""),
        UserModel(id: "004", name: "Raquel", email: "andreluisarns@gmail.com", jobDescription: "Dev iOS", personalDescription: "", imageURL: ""),
        UserModel(id: "005", name: "Neidi", email: "andreluisarns@gmail.com", jobDescription: "Dev iOS", personalDescription: "", imageURL: ""),
        UserModel(id: "006", name: "Gonzatto", email: "andreluisarns@gmail.com", jobDescription: "Dev iOS", personalDescription: "", imageURL: ""),
        UserModel(id: "007", name: "Fábio Binder", email: "andreluisarns@gmail.com", jobDescription: "Dev iOS", personalDescription: "", imageURL: ""),
        UserModel(id: "008", name: "Pastre", email: "andreluisarns@gmail.com", jobDescription: "Dev iOS", personalDescription: "", imageURL: "")
    ]
    
    @Published var businessUsersList: [BusinessUser] = [
        BusinessUser(userId: "001", businessId: "", role: .employee, userTasks: []),
        BusinessUser(userId: "002", businessId: "", role: .manager, userTasks: []),
        BusinessUser(userId: "003", businessId: "", role: .admin, userTasks: []),
        BusinessUser(userId: "004", businessId: "", role: .employee, userTasks: []),
        BusinessUser(userId: "005", businessId: "", role: .employee, userTasks: []),
        BusinessUser(userId: "006", businessId: "", role: .employee, userTasks: []),
        BusinessUser(userId: "007", businessId: "", role: .employee, userTasks: []),
        BusinessUser(userId: "008", businessId: "", role: .employee, userTasks: [])
    ]
    
    @Published var modelList: [Model] = []
    
    @Published var selectedOption: SettingsOptions
    @Published var selectedUserModel: UserModel?
    
    init() {
        selectedOption = .users
        bind()
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
            businessUsersList.removeAll(where: { $0.userId == id })
            userModelsList.removeAll(where: { $0.id == id })
            modelList.removeAll(where: {$0.userModel.id == id})
        }
    }
}

enum SettingsOptions: String, CaseIterable {
    case general = "Geral"
    case users = "Usuários"
}
