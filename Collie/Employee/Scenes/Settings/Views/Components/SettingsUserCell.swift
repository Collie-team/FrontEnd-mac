import SwiftUI

struct SettingsUserCell: View {
    @Binding var model: SettingsViewModel.Model
    var handleUserDeletion: () -> ()
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            UserIconView(user: model.userModel)
                .frame(width: 40, height: 40)
            .padding(.trailing)

            GeometryReader { geometry in
                HStack(alignment: .center, spacing: 0) {
                    Text("\(model.userModel.name)")

                    Spacer()

                    VStack {
                        Text(verbatim: "\(model.userModel.email)")
                            .font(.system(size: 15))
                            .opacity(0.5)
                            

                    }
                    .frame(width: geometry.size.width * ListComponents.alignWith(component: .email))

                    RoleSelectionPicker(roleSelected: $model.businessUser.role, onRoleChange: { role in
                        model.businessUser.role = role
                    })
                    .frame(width: geometry.size.width * ListComponents.alignWith(component: .role))

                    IconButton(imageSystemName: "trash") {
                        handleUserDeletion()
                    }
                    .padding(.leading, 32)
                }
            }
            .foregroundColor(.black)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .modifier(CustomBorder())
    }
}

//struct SettingsUserCell_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsUserCell(model: .init(userModel: UserModel(name: "André Arns", email: "andreluisarns@gmail.com", jobDescription: "", personalDescription: "", imageURL: ""), businessUser: .init(userId: "", businessId: "", role: .manager, userTasks: [])), handleUserDeletion: {})
//    }
//}
