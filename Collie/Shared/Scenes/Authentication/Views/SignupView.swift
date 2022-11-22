import SwiftUI

struct SignupView: View {
    var completion: (UserModel, String) -> ()
    @EnvironmentObject var viewModel: AuthenticationViewModel
    @State var on = true
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 16) {
                Text("Seja bem-vindo!")
                    .collieFont(textStyle: .largeTitle)
                Text("Integre com seu time durante o onboarding.")
                    .collieFont(textStyle: .regularText)
                    .foregroundColor(Color.collieCinzaEscuro)
            }
            .padding(.bottom, 40)
            
            HStack(alignment: .center) {
                Text("Registrar")
                    .collieFont(textStyle: .title)
                Spacer()
                
                NakedButton(title: "Fazer login") {
                    viewModel.resetUser()
                    withAnimation(.spring()) {
                        viewModel.authenticationMode = .login
                    }
                }
            }
            .padding(.bottom)
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Primeiro nome")
                            .collieFont(textStyle: .regularText)
                        CustomTextField("Primeiro Nome", text: $viewModel.currentUser.firstName)
                    }
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("Sobrenome")
                            .collieFont(textStyle: .regularText)
                        CustomTextField("Sobrenome", text: $viewModel.currentUser.lastName)
                    }
                }
                .padding(.bottom, 16)
                VStack(alignment: .leading) {
                    Text("E-mail")
                        .collieFont(textStyle: .regularText)
                    CustomTextField("E-mail", text: $viewModel.currentUser.email) {
                        return (viewModel.currentUser.isValidEmail() || viewModel.currentUser.email == "") && viewModel.authenticationStatus != .emailInUse
                    }
                    Text("\(Image(systemName: "exclamationmark.circle.fill")) Esse e-mail já está em uso, tente outro")
                        .collieFont(textStyle: .regularText)
                        .foregroundColor(Color.collieVermelho)
                        .opacity(viewModel.authenticationStatus == .emailInUse ? 1 : 0)
                }
                VStack(alignment: .leading) {
                    Text("Senha")
                        .collieFont(textStyle: .regularText)
                    
                    CustomSecureView("Senha", text: $viewModel.currentUser.password) {
                        return viewModel.currentUser.isValidPassword() || viewModel.currentUser.password == ""
                    }
                    
                    Text("\(Image(systemName: "info.circle")) Deve conter ao menos 6 caracteres, incluindo uma letra maiúscula, uma minúscula e um número")
                        .collieFont(textStyle: .regularText, textSize: 14)
                        .foregroundColor(Color.collieCinzaEscuro.opacity(0.8))
                        .lineLimit(2)
                }
                .padding(.bottom, 8)
                
                VStack(alignment: .leading) {
                    Text("Confirmar senha")
                        .collieFont(textStyle: .regularText)
                    
                    CustomSecureView("Confirmar senha", text: $viewModel.currentUser.passwordConfirmation) {
                        return viewModel.currentUser.password == viewModel.currentUser.passwordConfirmation
                    }
                    
                    Text("\(Image(systemName: "exclamationmark.circle.fill")) Senha dos campos não é a mesma")
                        .collieFont(textStyle: .regularText)
                        .foregroundColor(Color.collieVermelho)
                        .opacity(viewModel.currentUser.password != viewModel.currentUser.passwordConfirmation && viewModel.currentUser.passwordConfirmation != "" ? 1 : 0)
                }
                .padding(.bottom, 8)
                
                VStack(alignment: .leading) {
                    Toggle(isOn: $viewModel.currentUser.agreementToggle) {
                        HStack(spacing: 4) {
                            Text("Concordo com as")
                                .collieFont(textStyle: .regularText)
                            Text("políticas da plataforma")
                                .underline()
                                .collieFont(textStyle: .subtitle, textSize: 16)
                                .foregroundColor(Color.collieRoxo)
                        }
                    }
                    .toggleStyle(CheckboxStyle())
                    Toggle(isOn: $viewModel.currentUser.mailingToggle) {
                        Text("Desejo receber e-mails com novidades")
                            .collieFont(textStyle: .regularText)
                    }
                    .toggleStyle(CheckboxStyle())
                }
            }
            
            Spacer()
            
            DefaultButton(
                label: "cadastrar",
                backgroundColor: Color.collieAzulEscuro,
                isButtonDisabled: !viewModel.signupEnabled,
                maxWidth: .infinity,
                handleSend: {
                    viewModel.authenticationStatus = .valid
                    viewModel.createUser() { user, token in
                        completion(user, token)
                    }
                }
            )
        }
        .foregroundColor(.black)
        .padding(.horizontal, 60)
        .padding(.vertical, 42)
        .background(Color.white)
        .cornerRadius(8)
        .modifier(CustomBorder())
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView(completion: {_,_  in})
            .environmentObject(AuthenticationViewModel())
    }
}
