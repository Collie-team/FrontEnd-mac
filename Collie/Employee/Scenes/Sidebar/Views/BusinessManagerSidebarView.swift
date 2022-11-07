import SwiftUI

struct BusinessManagerSidebarView: View {
    @ObservedObject var viewModel = BusinnesManagerSidebarViewModel()
    var handleSignOut: () -> ()
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(spacing: 32) {
                    Image("logoCollie")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150)
                        .padding(.top)
                        .padding(.horizontal)
                    
                    VStack {
                        ForEach(viewModel.sidebarItens) { sidebarItem in
                            SidebarItemView(sidebarItem: sidebarItem, isSelected: viewModel.isSideBarItemSelected(sidebarItem)) {
                                viewModel.selectSideBarItem(sidebarItem)
                            }
                        }
                    }
                }
                Spacer()
                
                HStack {
                    Image(systemName: "scooter")
                    Text("Sair da conta")
                    Spacer()
                }
                .foregroundColor(.white)
                .padding(.trailing)
                .frame(height: 50)
                .font(.system(size: 18, weight: .regular))
                .background(Color.collieAzulEscuro)
                .onTapGesture {
                    handleSignOut()
                }
            }
            .background(Color.collieAzulEscuro)
            
            VStack {
                switch viewModel.selectedItem.option {
                case .dashboard:
                    DashboardView()
                case .journeys:
                    BusinessJourneyListView()
                case .teamList:
                    TeamListView()
//                case .payments:
//                    PaymentsView()
                case .settings:
                    SettingsView()
                default:
                    Text("Error")
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigation) {
                Button(action: toggleSidebar, label: { // 1
                    Image(systemName: "sidebar.leading")
                })
            }
        }
        .onAppear {
            viewModel.handleAppear()
        }
    }
    
    private func toggleSidebar() {
        #if os(iOS)
        #else
        NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
        #endif
    }
}

