import SwiftUI

struct BusinessSidebarView: View {
    @EnvironmentObject var rootViewModel: RootViewModel
    @StateObject var viewModel = BusinessSidebarViewModel() // State to prevent reloading
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
                
                SignOutSidebarItem {
                    rootViewModel.exitCurrentWorkspace()
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
                        .environmentObject(viewModel)
                case .settings:
                    SettingsView()
                case .profile:
                    ProfileView()
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

