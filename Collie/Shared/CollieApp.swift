import SwiftUI
import FirebaseCore
import FirebaseAuth

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        //        FirebaseApp.configure()
    }
    
    func applicationWillFinishLaunching(_ notification: Notification) {
        FirebaseApp.configure()
    }
}

@main
struct CollieApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            EmployeeSidebarView(handleSignOut: {
                
            })
            .colorScheme(.light)
            .frame(minWidth: 1200, minHeight: 800)
        }
    }
}
