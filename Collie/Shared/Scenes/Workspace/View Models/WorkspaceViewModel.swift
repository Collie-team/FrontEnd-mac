import Foundation

final class WorkspaceViewModel: ObservableObject {
    @Published var workspacesAvailable: [Business] = []
    
    @Published var workspaceName: String = ""
    
    @Published var selectedWorkspace: Business?
    
    func handleAppear() {
        fetchWorkspaces()
    }
    
    func fetchWorkspaces() {
        // TO DO
        let workspaces: [Business] = [
            Business(name: "Aurea", description: "", journeys: [], usersIds: ["", "", "", ""]),
            Business(name: "Roda da Vida", description: "", journeys: [], usersIds: ["", "", "", ""])
        ]
        self.workspacesAvailable = workspaces
    }
    
    func createNewWorkspace(completion: () -> ()) {
        if !workspaceName.isEmpty {
            let business = Business(id: UUID().uuidString, name: workspaceName, description: "", journeys: [], usersIds: [])
            workspacesAvailable.append(business)
            selectWorkspace(business) {
                completion()
            }
        }
    }
    
    func selectWorkspace(_ business: Business, completion: () -> ()) {
        self.selectedWorkspace = business
        completion()
    }
}
