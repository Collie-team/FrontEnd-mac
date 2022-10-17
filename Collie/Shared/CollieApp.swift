import SwiftUI

@main
struct CollieApp: App {
    var body: some Scene {
        WindowGroup {
            EmployeeSidebarView()
                .preferredColorScheme(.light)
        }
        .windowToolbarStyle(.unified)
        .commands {
            SidebarCommands()
        }
    }
}
