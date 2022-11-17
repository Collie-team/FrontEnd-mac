import SwiftUI

struct RoleSelectionPicker: View {
    @Binding var roleSelected: BusinessUserRoles
    @Binding var workspaceAdmins: Int
    var onRoleChange: (BusinessUserRoles) -> ()
    
    var body: some View {
        Menu(content: {
            ForEach(BusinessUserRoles.allCases, id: \.self) { role in
                Button {
                    roleSelected = role
                    print(roleSelected.rawValue)
                } label: {
                    Text(role.getRoleText())
                }
                .buttonStyle(.plain)
            }
        }, label: {
            Text(roleSelected.getRoleText())
        })
        .onChange(of: roleSelected) { newRole in
            onRoleChange(newRole)
        }
        .disabled(roleSelected == .admin && workspaceAdmins <= 1)
    }
}

struct RoleSelectionPicker_Previews: PreviewProvider {
    static var previews: some View {
        RoleSelectionPicker(roleSelected: .constant(.manager), workspaceAdmins: .constant(1), onRoleChange: {_ in})
            .environmentObject(RootViewModel())
    }
}
