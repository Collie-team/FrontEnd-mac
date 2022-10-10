//
//  ResetPasswordView.swift
//  Collie
//
//  Created by Pablo Penas on 10/10/22.
//

import SwiftUI

struct ResetPasswordView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 26) {
            Button(action: {
                withAnimation(.spring()) {
                    viewModel.authenticationMode = .login
                }
            }) {
                Image(systemName: "arrow.left")
                    .font(.system(size: 34, weight: .bold))
            }
            .buttonStyle(.plain)
            Text("Redefinir sua senha")
                .font(.system(size: 34, weight: .bold))
            
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("Enviar e-mail")
                    CustomTextField("E-mail", text: $viewModel.currentUser.email)  {
                        return viewModel.currentUser.isValidEmail() || viewModel.currentUser.email == ""
                    }
                }
            }
            Spacer()
            Button(action: {
                viewModel.resetPassword()
                withAnimation(.spring()) {
                    viewModel.authenticationMode = .login
                }
            }) {
                Text("Enviar e-mail")
                    .foregroundColor(.white)
                    .frame(height: 48)
                    .frame(maxWidth: 400)
                    .background(Color.black)
                    .cornerRadius(8)
            }
            .buttonStyle(.plain)
            .frame(maxWidth: .infinity)
            .disabled(!viewModel.currentUser.isValidEmail())
        }
        .foregroundColor(.black)
        .padding(.horizontal,60)
        .padding(.vertical,42)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .gray, radius: 4, x: 0, y: 4)
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
            .environmentObject(AuthenticationViewModel())
    }
}
