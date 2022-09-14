import Foundation

enum SidebarItemOption {
    case dashboard
    case journeys
    case teamList
    case payments
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
        }
    }
    
    private func getSystemImageName(for option: SidebarItemOption) -> String {
        switch option {
        case .dashboard:
            return "star"
        case .journeys:
            return "star"
        case .teamList:
            return "star"
        case .payments:
            return "star"
        }
    }
}
