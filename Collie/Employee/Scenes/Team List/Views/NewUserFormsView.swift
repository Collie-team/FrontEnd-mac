import SwiftUI

struct NewUserFormsView: View {
    @EnvironmentObject var rootViewModel: RootViewModel
    @State var newUser = UserModel(name: "", email: "", jobDescription: "", personalDescription: "", imageURL: "")
    @State var showList = false
    @State var selectedRole: BusinessUserRoles = .employee
    @State var emailSentLabel: Bool = false {
        didSet {
            if emailSentLabel == true {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.emailSentLabel = false
                }
            }
        }
    }
    
    var handleClose: () -> ()
    var handleEmailSend: () -> ()
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Image(systemName: "person.crop.circle.badge.plus")
                    .collieFont(textStyle: .title)
                    .padding(.top, 32)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Adicionar pessoas")
                        .collieFont(textStyle: .title)
                
                    Text("Convide novos usuários para a plataforma de forma rápida.")
                        .collieFont(textStyle: .regularText)
                }
                .padding(.top, 32)
                
                
                Spacer()
                
                CloseButton {
                    handleClose()
                }
                .padding(.top)
            }
            .foregroundColor(.white)
            .padding(.bottom, 32)
            .frame(maxWidth: .infinity)
            .padding(.leading, 36)
            .padding(.trailing, 16)
            .background(Color.collieRoxo)
            
            VStack {
                HStack {
                    Image(systemName: "person.2.fill")
                    
                    Text("Enviar convite ao novo colaborador")
                        .fontWeight(.semibold)
                    
                    Spacer()
                }
                .collieFont(textStyle: .regularText)
                .foregroundColor(.black)
                .padding(.trailing, 32)
                .padding(.top)
                
                HStack(alignment: .top, spacing: 16) {
                    CustomTextField("E-mail", text: $newUser.email)

                    RoleSelectionDropdown(selectedRole: $selectedRole)
                }
                .foregroundColor(.black)
                
                DefaultButton(
                    label: "Enviar",
                    backgroundColor: Color.collieRoxo,
                    isButtonDisabled: verifyEmail(email: newUser.email),
                    handleSend: {
                        rootViewModel.inviteUser(userToAdd: newUser, role: selectedRole) {
                            handleEmailSend()
                        }
                    }
                )
                .frame(maxWidth: 290)
            }
            .padding(.horizontal, 36)
            .padding(.bottom)
        }
        .background(Color.collieCinzaClaro)
        .frame(width: 600)
        .cornerRadius(8)
        .modifier(CustomBorder())
    }
    
    func verifyEmail(email: String) -> Bool {
        return !NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}").evaluate(with: email)
    }
}

struct NewUserFormsView_Previews: PreviewProvider {
    static var previews: some View {
        NewUserFormsView(handleClose: {}, handleEmailSend: {})
            .environmentObject(RootViewModel())
            .background(Color.black)
    }
}
