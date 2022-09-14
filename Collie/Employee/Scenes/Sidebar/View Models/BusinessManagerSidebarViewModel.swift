import Foundation
import SwiftUI

final class BusinnesManagerSidebarViewModel: ObservableObject {
    @Published var selectedItem: SidebarItem = .init(option: .dashboard)
    @Published var sidebarItens: [SidebarItem] = [
        .init(option: .dashboard),
        .init(option: .journeys),
        .init(option: .teamList),
        .init(option: .payments)
    ]
    
    func selectSideBarItem(_ sidebarItem: SidebarItem) {
        self.selectedItem = sidebarItem
    }
    
    func isSideBarItemSelected(_ sidebarItem: SidebarItem) -> Bool {
        self.selectedItem.id == sidebarItem.id
    }
    
    func handleAppear() {
        self.selectedItem = self.sidebarItens[0]
    }
}


