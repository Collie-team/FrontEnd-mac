import SwiftUI

struct BusinessManagerSidebarView: View {
    @ObservedObject var viewModel = BusinnesManagerSidebarViewModel()
    
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
            }
            .background(Color.collieAzulEscuro)
            
            switch viewModel.selectedItem.option {
            case .dashboard:
                DashboardView()
            case .journeys:
                JourneyListView()
            case .teamList:
                TeamListView()
            case .payments:
                PaymentsView()
            }
        }
        .onAppear {
            viewModel.handleAppear()
        }
    }
}

struct BusinessManagerSidebarView_Previews: PreviewProvider {
    static var previews: some View {
        BusinessManagerSidebarView()
    }
}
