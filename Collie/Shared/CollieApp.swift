import SwiftUI
import FirebaseCore
import FirebaseAuth

class AppDelegate: NSObject, NSApplicationDelegate {
//    func applicationDidFinishLaunching(_ notification: Notification) {
//        FirebaseApp.configure()
//    }
    func applicationWillFinishLaunching(_ notification: Notification) {
        FirebaseApp.configure()
    }
}

@main
struct CollieApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
//    init() {
//        FirebaseApp.configure()
//        print("init")
//    }
    var body: some Scene {
        WindowGroup {
            AuthenticationView()
            //            TeamListView()
        }
        //        WindowGroup {
        //            BusinessManagerSidebarView()
        //                .preferredColorScheme(.light)
        //        }
        //        .windowToolbarStyle(.unified)
        //        .commands {
        //            SidebarCommands()
        //        }
    }
    
}
