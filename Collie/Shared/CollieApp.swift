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
    @StateObject var rootViewModel = RootViewModel()
    
    var body: some Scene {
        WindowGroup {
//            SettingsView()
            RootView()
                .colorScheme(.light)
                .frame(minWidth: 1200, minHeight: 800)
                .environmentObject(rootViewModel)
        }
    }
}
