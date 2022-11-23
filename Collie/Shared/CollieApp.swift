import SwiftUI
import FirebaseCore
import FirebaseAuth

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationWillFinishLaunching(_ notification: Notification) {
        FirebaseApp.configure()
    }
<<<<<<< HEAD
    
=======
>>>>>>> develop
//    func applicationDidFinishLaunching(_ notification: Notification) {
//        FirebaseApp.configure()
//    }
}

@main
struct CollieApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            RootView()
//            ProfileView()
//            LoadingView()
                .colorScheme(.light)
                .frame(minWidth: 1200, minHeight: 800)
        }
    }
}
