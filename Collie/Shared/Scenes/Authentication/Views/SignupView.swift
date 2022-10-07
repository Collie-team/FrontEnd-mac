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
                    withAnimation() {
                        viewModel.authenticationMode = .login
                    }
                }) {
                    Text("Fazer login")
                        .foregroundColor(.blue)
                }
                .buttonStyle(.plain)
            }
            .padding(.bottom)
            
            VStack(alignment: .leading, spacing: 26) {
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
                VStack(alignment: .leading) {
                    Text("E-mail")
                    CustomTextField("E-mail", text: $viewModel.currentUser.email)
                }
                VStack(alignment: .leading) {
                    Text("Senha")
                    CustomSecureView("Senha", text: $viewModel.currentUser.password)
                }
                VStack(alignment: .leading) {
                    Text("Confirmar senha")
                    CustomSecureView("Confirmar senha", text: $viewModel.currentUser.passwordConfirmation)
                }
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
