import SwiftUI

struct DisplayFormView: View {
    @Binding var rootViewModelUser: UserModel
    @Binding var rootViewModelBusinessUser: BusinessUser?
    @State var currentUser: UserModel
    @Binding var editingMode: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                Button(action: {
                    withAnimation {
                        editingMode = true
                    }
                }) {
                    Text("Editar \(Image(systemName: "square.and.pencil"))")
                        .foregroundColor(Color.collieRoxo)
                        .collieFont(textStyle: .subtitle)
                }
                .buttonStyle(.plain)
                .contentShape(Rectangle())
            }
            VStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Nome do usuário")
                        .collieFont(textStyle: .regularText)
                    HStack {
                        Text(currentUser.name)
                            .collieFont(textStyle: .smallTitle)
                        Spacer()
                    }
                }
                
                Divider()
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text("Cargo")
                        .collieFont(textStyle: .regularText)
                    HStack {
                        Text(currentUser.jobDescription == "" ? "Sem cargo" : currentUser.jobDescription)
                            .collieFont(textStyle: .subtitle)
                        Spacer()
                    }
                }
                
                Divider()
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Breve descrição")
                        .collieFont(textStyle: .regularText)
                    HStack {
                        Text(currentUser.personalDescription == "" ? "Sem descrição" : currentUser.personalDescription)
                            .collieFont(textStyle: .subtitle)
                        Spacer()
                    }
                }
                
                Divider()
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Papel")
                        .collieFont(textStyle: .regularText)
                    HStack {
                        Text(rootViewModelBusinessUser!.role.getRoleText())
                            .collieFont(textStyle: .regularText)
                        Spacer()
                    }
                }
            }
            .frame(maxWidth: 600)
        }
        .onChange(of: rootViewModelUser) { updatedUser in
            currentUser = updatedUser
        }
    }
}

struct DisplayFormView_Previews: PreviewProvider {
    static var previews: some View {
        DisplayFormView(rootViewModelUser: .constant(UserModel(id: "", name: "", email: "", jobDescription: "", personalDescription: "", imageURL: "")), rootViewModelBusinessUser: .constant(BusinessUser(userId: "", businessId: "", role: .admin, userTasks: [])), currentUser: UserModel(id: "", name: "", email: "", jobDescription: "", personalDescription: "", imageURL: ""), editingMode: .constant(true))
    }
}
