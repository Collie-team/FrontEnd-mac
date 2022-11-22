import SwiftUI

struct EditingFormView: View {
    @EnvironmentObject var rootViewModel: RootViewModel
    @Binding var rootViewModelBusinessUser: BusinessUser?
    @State var currentUser: UserModel
    @Binding var editingMode: Bool
    
    var body: some View {
        VStack {
            VStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Nome do usuário")
                        .collieFont(textStyle: .regularText)
                    CustomTextField("Nome", text: $currentUser.name)
                }
                
                Divider()
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Cargo")
                        .collieFont(textStyle: .regularText)
                    CustomTextField("Cargo", text: $currentUser.jobDescription)
                }
                
                Divider()
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Breve descrição")
                        .collieFont(textStyle: .regularText)
                    CustomTextField("Description", text: $currentUser.personalDescription)
                }
                
                Divider()
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Papel")
                        .collieFont(textStyle: .regularText)
                    HStack {
                        Text(rootViewModelBusinessUser!.role.getRoleText())
                            .collieFont(textStyle: .subtitle)
                        Spacer()
                    }
                }
                
                Divider()
                
                HStack(spacing: 16) {
                    SimpleButton(label: "Reverter alterações") {
                        withAnimation {
                            editingMode = false
                        }
                    }
                    
                    SimpleButton(label: "Salvar alteraçoes") {
                        withAnimation {
                            rootViewModel.updateUser(userData: currentUser)
                            editingMode = false
                        }
                    }
        
                    Spacer()
                }
            }
            .frame(maxWidth: 600)
        }
    }
}

struct EditingFormView_Previews: PreviewProvider {
    static var previews: some View {
        EditingFormView(rootViewModelBusinessUser: .constant(nil), currentUser: UserModel(id: "", name: "", email: "", jobDescription: "", personalDescription: "", imageURL: ""), editingMode: .constant(true))
    }
}
