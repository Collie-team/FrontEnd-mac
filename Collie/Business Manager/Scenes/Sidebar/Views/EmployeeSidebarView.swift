import SwiftUI

struct EmployeeSidebarView: View {
    @EnvironmentObject var rootViewModel: RootViewModel
    @ObservedObject var viewModel = EmployeeSidebarViewModel()
    
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
                    rootViewModel.navigationState = .workspace
                }
            }
            .background(Color.collieAzulEscuro)
            
            VStack {
                switch viewModel.selectedItem.option {
                case .journeys:
                    EmployeeJourneyListView()
                case .profile :
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

