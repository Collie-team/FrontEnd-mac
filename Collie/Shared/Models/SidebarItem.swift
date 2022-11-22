import Foundation
import SwiftUI

enum SidebarItemOption {
    case dashboard
    case journeys
    case teamList
    case payments
    case settings
    case profile
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
        case .profile:
            return "Perfil"
        }
    }
    
    private func getSystemImageName(for option: SidebarItemOption) -> String {
        switch option {
        case .dashboard:
            return "sparkles.tv"
        case .journeys:
            return "square.stack.3d.forward.dottedline"
        case .teamList:
            return "person.crop.rectangle.stack"
        case .payments:
            return "star"
        case .settings:
            return "gearshape"
        case .profile:
            return "person.crop.circle"
        }
    }
}
