//
//  LoginView.swift
//  Collie
//
//  Created by Pablo Penas on 05/10/22.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel
    @State var on = true
    var body: some View {
        VStack(alignment: .leading) {
            Text("Bem-vindo de volta!")
                .font(.system(size: 34, weight: .bold))
            Text("Integre com seu time durante o onboarding.")
                .font(.system(size: 17))
                .foregroundColor(Color.collieCinzaEscuro)
                .padding(.bottom, 62)
            HStack(alignment: .center) {
                Text("Login")
                    .font(.system(size: 28, weight: .bold))
                Spacer()
                Button(action: {
                    viewModel.resetUser()
                    withAnimation(.spring()) {
                        viewModel.authenticationMode = .signup
                    }
                }) {
                    Text("Registrar")
                        .foregroundColor(.blue)
                }
                .buttonStyle(.plain)
            }
            .padding(.bottom)
            
            VStack(alignment: .leading, spacing: 26) {
                VStack(alignment: .leading) {
                    Text("E-mail")
                    CustomTextField("E-mail", text: $viewModel.currentUser.email)  {
                        return viewModel.currentUser.isValidEmail() || viewModel.currentUser.email == ""
                    }
                }
                VStack(alignment: .leading) {
                    Text("Senha")
                    CustomSecureView("Senha", text: $viewModel.currentUser.password)
                    
                    HStack {
                        Text("\(Image(systemName: "exclamationmark.circle.fill")) Credenciais inválidas, tente novamente")
                            .font(.system(size: 13))
                            .foregroundColor(Color.collieVermelho)
                            .opacity(viewModel.authenticationStatus == .invalidPassword ? 1 : 0)
                        Spacer()
                        Button(action: {
                            withAnimation(.spring()) {
                                viewModel.authenticationMode = .passwordReset
                            }
                        }) {
                            Text("Esqueci a senha")
                                .foregroundColor(Color.collieCinzaEscuro)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            Spacer()
            Button(action: {
                viewModel.loginUser()
            }) {
                Text("Entrar")
                    .foregroundColor(.white)
                    .frame(height: 48)
                    .frame(maxWidth: 400)
                    .background(Color.black)
                    .cornerRadius(8)
            }
            .buttonStyle(.plain)
            .frame(maxWidth: .infinity)
            .disabled(!viewModel.loginEnabled)
        }
        .foregroundColor(.black)
        .padding(.horizontal,60)
        .padding(.vertical,42)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .gray, radius: 4, x: 0, y: 4)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AuthenticationViewModel())
    }
}
