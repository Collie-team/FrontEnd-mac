import SwiftUI

@main
struct CollieApp: App {
    var body: some Scene {
        WindowGroup {
            BusinessManagerSidebarView()
        }.commands {
            SidebarCommands()
        }
    }
}
