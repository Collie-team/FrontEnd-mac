import Foundation

final class WorkspaceViewModel: ObservableObject {
    enum WorkspaceViewState {
        case loading
        case loadingWorkspace
        case createForm
        case noWorkspacesFound
        case workspaceList
    }
    @Published var workspaceViewState: WorkspaceViewState = .loading
    var workspacesAvailable: [Business] = []
    
    @Published var workspaceName: String = ""
    
    @Published var selectedWorkspace: Business?
    
    private let businessSubscriptionService = BusinessSubscriptionService()
    
    var newWorkspaceHandler: (String, @escaping ([Business]) -> ()) -> () = { _,_  in }
    var handleWorkspaceSelection: (Business) -> () = {_ in }

    func createNewWorkspace() {
        let business = Business(id: UUID().uuidString, name: workspaceName, description: "", journeys: [], tasks: [], events: [])
        self.selectedWorkspace = business
        self.workspaceViewState = .loadingWorkspace
        newWorkspaceHandler(workspaceName) { availableBusiness in
            self.workspacesAvailable = availableBusiness
            self.selectWorkspace(business)
        }
    }
    
    func selectWorkspace(_ business: Business) {
        self.selectedWorkspace = business
        handleWorkspaceSelection(business)
    }
}
