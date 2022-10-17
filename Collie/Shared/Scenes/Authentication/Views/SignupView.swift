//
//  SignupView.swift
//  Collie
//
//  Created by Pablo Penas on 05/10/22.
//

import SwiftUI

struct SignupView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel
    @State var on = true
    var body: some View {
        VStack(alignment: .leading) {
            Text("Seja bem-vindo!")
                .font(.system(size: 34, weight: .bold))
            Text("Integre com seu time durante o onboarding.")
                .font(.system(size: 17))
                .foregroundColor(Color.collieCinzaEscuro)
            Spacer()
            HStack(alignment: .center) {
                Text("Registrar")
                    .font(.system(size: 28, weight: .bold))
                Spacer()
                Button(action: {
                    viewModel.resetUser()
                    withAnimation(.spring()) {
                        viewModel.authenticationMode = .login
                    }
                }) {
                    Text("Fazer login")
                        .foregroundColor(.blue)
                }
                .buttonStyle(.plain)
            }
            .padding(.bottom)
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Primeiro nome")
                        CustomTextField("Primeiro Nome", text: $viewModel.currentUser.firstName)
                    }
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("Sobrenome")
                        CustomTextField("Sobrenome", text: $viewModel.currentUser.lastName)
                    }
                }
                .padding(.bottom, 16)
                VStack(alignment: .leading) {
                    Text("E-mail")
                    CustomTextField("E-mail", text: $viewModel.currentUser.email) {
                        return (viewModel.currentUser.isValidEmail() || viewModel.currentUser.email == "") && viewModel.authenticationStatus != .emailInUse
                    }
                    Text("\(Image(systemName: "exclamationmark.circle.fill")) Esse e-mail já está em uso, tente outro")
                        .font(.system(size: 13))
                        .foregroundColor(Color.collieVermelho)
                        .opacity(viewModel.authenticationStatus == .emailInUse ? 1 : 0)
                }
                VStack(alignment: .leading) {
                    Text("Senha")
                    CustomSecureView("Senha", text: $viewModel.currentUser.password) {
                        return viewModel.currentUser.isValidPassword() || viewModel.currentUser.password == ""
                    }
                    Text("\(Image(systemName: "info.circle")) Deve conter ao menos 6 caracteres, incluindo uma letra maiúscula, uma minúscula e um número")
                        .font(.system(size: 13))
                        .foregroundColor(Color.collieCinzaEscuro.opacity(0.8))
                }
                .padding(.bottom, 8)
                VStack(alignment: .leading) {
                    Text("Confirmar senha")
                    CustomSecureView("Confirmar senha", text: $viewModel.currentUser.passwordConfirmation) {
                        return viewModel.currentUser.password == viewModel.currentUser.passwordConfirmation
                    }
                    Text("\(Image(systemName: "exclamationmark.circle.fill")) Senha dos campos não é a mesma")
                        .font(.system(size: 13))
                        .foregroundColor(Color.collieVermelho)
                        .opacity(viewModel.currentUser.password != viewModel.currentUser.passwordConfirmation && viewModel.currentUser.passwordConfirmation != "" ? 1 : 0)
                }
                .padding(.bottom, 8)
                VStack(alignment: .leading) {
                    Toggle(isOn: $viewModel.currentUser.agreementToggle) {
                        Text("Concordo com as ") +
                        Text("políticas da plataforma").foregroundColor(Color.collieRoxo)
                            .underline()
                    }
                    .toggleStyle(CheckboxStyle())
                    Toggle(isOn: $viewModel.currentUser.mailingToggle) {
                        Text("Desejo receber e-mails com novidades")
                    }
                    .toggleStyle(CheckboxStyle())
                }
            }
            Spacer()
            Button(action: {
                viewModel.authenticationStatus = .valid
                viewModel.createUser()
            }) {
                Text("Cadastrar")
                    .foregroundColor(.white)
                    .frame(height: 48)
                    .frame(maxWidth: 400)
                    .background(Color.black)
                    .cornerRadius(8)
            }
            .buttonStyle(.plain)
            .frame(maxWidth: .infinity)
            .disabled(!viewModel.signupEnabled)
        }
        .foregroundColor(.black)
        .padding(.horizontal,60)
        .padding(.vertical,42)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .gray, radius: 4, x: 0, y: 4)
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
            .environmentObject(AuthenticationViewModel())
    }
}
