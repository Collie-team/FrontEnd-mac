import Foundation

final class WorkspaceViewModel: ObservableObject {
    enum WorkspaceViewState {
        case loading
        case loadingWorkspace
        case createForm
        case noWorkspacesFound
        case workspaceList
        case loginWorkspace
    }
    
    enum CodeResponse: String {
        case none = ""
        case success = "Sucesso. Você entrou no workspace."
        case error = "Falha. Código inválido."
    }
    
    @Published var workspaceViewState: WorkspaceViewState = .loading
    @Published var workspacesAvailable: [Business] = []
    
    @Published var workspaceName: String = ""
    @Published var workspaceCode: String = ""
    @Published var codeResponse: CodeResponse = .none
    
    @Published var selectedWorkspace: Business?
    
    private let businessSubscriptionService = BusinessSubscriptionService()
    
    var newWorkspaceHandler: (String, @escaping (Business) -> ()) -> () = { _,_  in }
    var handleWorkspaceSelection: (Business) -> () = {_ in }

    func createNewWorkspace() {
        let business = Business(id: UUID().uuidString, name: workspaceName, description: "", journeys: [], tasks: [], categories: [], events: [])
        self.selectedWorkspace = business
        self.workspaceViewState = .loadingWorkspace
        newWorkspaceHandler(workspaceName) { newBusiness in
            self.workspacesAvailable = [newBusiness]
            self.selectWorkspace(newBusiness)
        }
    }
    
    func selectWorkspace(_ business: Business) {
        self.selectedWorkspace = business
        handleWorkspaceSelection(business)
    }
    
    func loginWorkspace(user: UserModel, _ completion: @escaping ([Business], [BusinessUser]) -> Void) {
        businessSubscriptionService.loginBusiness(authenticationToken: "", code: workspaceCode, user: user) { business, userBusiness in
            if !business.isEmpty {
                self.codeResponse = .success
                self.workspacesAvailable = business
                completion(business, userBusiness)
            } else {
                self.codeResponse = .error
            }
        }
    }
}
