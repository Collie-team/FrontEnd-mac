import SwiftUI

struct RoleSelectionPicker: View {
    @Binding var roleSelected: BusinessUserRoles
    
    var onRoleChange: (BusinessUserRoles) -> ()
    
    var body: some View {
        Menu(content: {
            ForEach(BusinessUserRoles.allCases, id: \.self) { role in
                Button {
                    roleSelected = role
                    print(roleSelected.rawValue)
                } label: {
                    Text(role.rawValue)
                }
                .buttonStyle(.plain)
            }
        }, label: {
            Text(roleSelected.rawValue)
        })
        .onChange(of: roleSelected) { newRole in
            print("Role changed")
            self.roleSelected = newRole
            onRoleChange(newRole)
        }
    }
}

struct RoleSelectionPicker_Previews: PreviewProvider {
    static var previews: some View {
        RoleSelectionPicker(roleSelected: .constant(.manager), onRoleChange: {_ in})
    }
}
