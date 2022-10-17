//
//  AuthenticationView.swift
//  Collie
//
//  Created by Pablo Penas on 04/10/22.
//

import SwiftUI

struct AuthenticationView: View {
    @StateObject var viewModel = AuthenticationViewModel()
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Image("logoCollieBlack")
                        .resizable()
                        .aspectRatio(204/41.42, contentMode: .fit)
                        .frame(maxWidth: 204)
                    Spacer()
                }
                .padding(.bottom, 64)
                HStack(alignment: .top, spacing: 70) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("A melhor maneira de gerenciar o onboarding de novos colaboradores")
                            .font(.system(size: 34, weight: .bold))
                            .foregroundColor(Color.collieCinzaEscuro)
                        Rectangle()
                            .fill(Color.collieRoxo)
                            .frame(width: 36, height: 5)
                        Text("Integre novos colaboradores com seus times, gerencie e acompanhe o processo de forma simples e prática.")
                            .font(.system(size: 20))
                            .foregroundColor(Color.collieCinzaEscuro)
                        Image("loginSplashImage")
                            .resizable()
                            .aspectRatio(884.7/724.52, contentMode: .fit)
                    }
                    .frame(maxWidth: geometry.size.width * 0.55, maxHeight: geometry.size.height * 0.75)
                    if viewModel.authenticationMode == .signup {
                        SignupView()
                            .frame(maxWidth: min(geometry.size.width * 0.4, 530), maxHeight: geometry.size.height * 0.75)
                            .environmentObject(viewModel)
                    } else if viewModel.authenticationMode == .login {
                        LoginView()
                            .frame(maxWidth: min(geometry.size.width * 0.4, 530), maxHeight: geometry.size.height * 0.75)
                            .environmentObject(viewModel)
                    } else {
                        ResetPasswordView()
                            .frame(maxWidth: min(geometry.size.width * 0.4, 530), maxHeight: geometry.size.height * 0.75)
                            .environmentObject(viewModel)
                    }
                }
                .onChange(of: viewModel.currentUser) { _ in
                    viewModel.validateSingUpFields()
                    viewModel.validateLoginFields()
                }
                Spacer()
            }
            .padding()
            .padding(.leading, 48)
            .padding(.top, 36)
            .background(Color.collieBranco)
        }
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}
