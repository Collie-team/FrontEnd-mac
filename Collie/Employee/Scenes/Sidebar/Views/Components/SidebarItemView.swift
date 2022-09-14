import SwiftUI

struct SidebarItemView: View {
    var sidebarItem: SidebarItem
    var isSelected: Bool
    var onTap: () -> ()
    
    let white = Color(red: 239/255, green: 239/255, blue: 242/255).opacity(0.4)
    
    var body: some View {
        HStack {
            Rectangle()
                .frame(width: 5)
                .foregroundColor(Color.collieRosaEscuro)
                .opacity(isSelected ? 1 : 0)
            Image(systemName: sidebarItem.systemImageName!)
            Text(sidebarItem.title!)
            Spacer()
        }
        .padding(.trailing)
        .frame(height: 50)
        .font(.system(size: 18, weight: isSelected ? .bold : .regular, design: .rounded))
        .background(isSelected ? white : Color.collieAzulEscuro)
        .onTapGesture {
            onTap()
        }
    }
}

struct SidebarItemView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarItemView(
            sidebarItem: .init(option: .dashboard),
            isSelected: true,
            onTap: {}
        )
    }
}
