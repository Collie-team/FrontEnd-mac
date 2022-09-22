import SwiftUI

@main
struct CollieApp: App {
    var body: some Scene {
        WindowGroup {
            BusinessManagerSidebarView()
                .preferredColorScheme(.light)
        }
        .windowToolbarStyle(.unified)
        .commands {
            SidebarCommands()
        }
    }
}
