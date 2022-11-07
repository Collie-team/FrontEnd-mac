import Foundation
import SwiftUI

enum SidebarItemOption {
    case dashboard
    case journeys
    case teamList
    case payments
    case settings
}

class SidebarItem: Identifiable {
    var id: String = UUID().uuidString
    var option: SidebarItemOption
    var title: String?
    var systemImageName: String?
    
    init(option: SidebarItemOption){
        self.option = option
        self.title = getTitle(for: option)
        self.systemImageName = getSystemImageName(for: option)
    }
    
    private func getTitle(for option: SidebarItemOption) -> String {
        switch option {
        case .dashboard:
            return "Dashboard"
        case .journeys:
            return "Jornadas"
        case .teamList:
            return "Time"
        case .payments:
            return "Pagamentos"
        case .settings:
            return "Configurações"
        }
    }
    
    private func getSystemImageName(for option: SidebarItemOption) -> String {
        switch option {
        case .dashboard:
            return "chart.xyaxis.line"
        case .journeys:
            return "burst"
        case .teamList:
            return "person.2"
        case .payments:
            return "star"
        case .settings:
            return "gear"
        }
    }
}
