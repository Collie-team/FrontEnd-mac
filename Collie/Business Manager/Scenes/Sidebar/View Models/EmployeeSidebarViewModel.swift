import Foundation
import SwiftUI

final class EmployeeSidebarViewModel: ObservableObject {
    @Published var selectedItem: SidebarItem = .init(option: .journeys)
    @Published var sidebarItens: [SidebarItem] = [
        .init(option: .journeys),
        .init(option: .profile)
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
