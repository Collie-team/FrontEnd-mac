import SwiftUI

struct BusinessManagerSidebarView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 32) {
                Image("logoCollie")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150)
                    .padding(.top)
                    .padding(.horizontal)
                
                List {
                    
                    NavigationLink(destination: DashboardView()) {
                        SidebarItem(title: "Dashboard", systemImageName: "star", isSelected: true)
                    }
                    NavigationLink(destination: JourneyListView()) {
                        SidebarItem(title: "Jornadas", systemImageName: "star", isSelected: false)
                    }
                }
                .listStyle(.sidebar)
            }
            .background(Color.collieAzulEscuro)
        }
    }
}

struct BusinessManagerSidebarView_Previews: PreviewProvider {
    static var previews: some View {
        BusinessManagerSidebarView()
    }
}
