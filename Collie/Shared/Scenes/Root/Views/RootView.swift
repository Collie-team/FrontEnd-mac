import SwiftUI

struct RootView: View {
    @State var showEmployeeView = false
    @State var showManagerView = false
    
    var body: some View {
        ZStack {
            VStack {
                SendButton(label: "Colaborador", isButtonDisabled: false) {
                    showEmployeeView = true
                }
                
                SendButton(label: "Gestor", isButtonDisabled: false) {
                    showManagerView = true
                }
            }
            
            if showEmployeeView {
                EmployeeSidebarView(handleSignOut: {
                    showEmployeeView = false
                })
            } else if showManagerView {
                BusinessManagerSidebarView(handleSignOut: {
                    showManagerView = false
                })
            }
        }
        .frame(maxWidth: NSScreen.main?.frame.width, maxHeight: NSScreen.main?.frame.height)
        .background(Color.collieBrancoFundo.ignoresSafeArea())
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
