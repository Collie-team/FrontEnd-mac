import SwiftUI
import FirebaseCore
import FirebaseAuth

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationWillFinishLaunching(_ notification: Notification) {
        FirebaseApp.configure()
    }
}

@main
struct CollieApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
//            ProfileView()
//                .environmentObject(RootViewModel())
            RootView()
//            ProfileView()
                .colorScheme(.light)
                .frame(minWidth: 1200, minHeight: 800)
        }
    }
}
