import SwiftUI

struct SidebarItem: View {
    var title: String
    var systemImageName: String
    var isSelected: Bool
    
    let white = Color(red: 239/255, green: 239/255, blue: 242/255).opacity(0.4)
    
    var body: some View {
        HStack {
            Rectangle()
                .frame(width: 5)
                .foregroundColor(Color.collieRosaEscuro)
                .opacity(isSelected ? 1 : 0)
            Image(systemName: systemImageName)
            Text(title)
        }
        .padding(.trailing)
        .frame(height: 50)
        .font(.system(size: 21, weight: isSelected ? .bold : .regular, design: .rounded))
        .background(isSelected ? white : Color.collieRoxo)
        .background(Color.collieRoxo)
    }
}

struct SidebarItem_Previews: PreviewProvider {
    static var previews: some View {
        SidebarItem(
            title: "Jornadas",
            systemImageName: "star",
            isSelected: true
        )
    }
}
