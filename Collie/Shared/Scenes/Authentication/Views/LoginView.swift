//
//  LoginView.swift
//  Collie
//
//  Created by Pablo Penas on 05/10/22.
//

import SwiftUI

struct LoginView: View {
    var completion: (UserModel, String) -> ()
    @EnvironmentObject var viewModel: AuthenticationViewModel
    @State var on = true
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 16) {
                Text("Bem-vindo de volta!")
                    .collieFont(textStyle: .largeTitle)
                Text("Integre com seu time durante o onboarding.")
                    .collieFont(textStyle: .regularText)
                    .foregroundColor(Color.collieCinzaEscuro)
            }
            .padding(.bottom, 40)
            
            HStack(alignment: .center) {
                Text("Login")
                    .collieFont(textStyle: .title)
                
                Spacer()
                
                NakedButton(title: "Registrar") {
                    viewModel.resetUser()
                    withAnimation(.spring()) {
                        viewModel.authenticationMode = .signup
                    }
                }
            }
            .padding(.bottom)
            
            VStack(alignment: .leading, spacing: 26) {
                VStack(alignment: .leading) {
                    Text("E-mail")
                        .collieFont(textStyle: .regularText)
                    
                    CustomTextField("E-mail", text: $viewModel.currentUser.email)  {
                        return viewModel.currentUser.isValidEmail() || viewModel.currentUser.email == ""
                    }
                }
                VStack(alignment: .leading) {
                    Text("Senha")
                        .collieFont(textStyle: .regularText)
                    CustomSecureView("Senha", text: $viewModel.currentUser.password)
                    
                    HStack {
                        Text("\(Image(systemName: "exclamationmark.circle.fill")) Credenciais inválidas, tente novamente")
                            .collieFont(textStyle: .regularText)
                            .foregroundColor(Color.collieVermelho)
                            .opacity(viewModel.authenticationStatus == .invalidPassword ? 1 : 0)
                        Spacer()
                        
                        Button(action: {
                            withAnimation(.spring()) {
                                viewModel.authenticationMode = .passwordReset
                            }
                        }) {
                            Text("esqueci minha senha")
                                .underline()
                                .collieFont(textStyle: .subtitle, textSize: 14)
                                .foregroundColor(Color.collieCinzaEscuro)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            
            Spacer()
            
            DefaultButton(
                label: "entrar",
                backgroundColor: Color.collieAzulEscuro,
                isButtonDisabled: !viewModel.loginEnabled,
                handleSend: {
                    viewModel.loginUser() { user,token  in
                        completion(user, token)
                    }
                }
            )
        }
        .foregroundColor(.black)
        .padding(.horizontal, 60)
        .padding(.vertical, 42)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .gray, radius: 4, x: 0, y: 4)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(completion: {_,_  in})
            .environmentObject(AuthenticationViewModel())
    }
}
