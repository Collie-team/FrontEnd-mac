import SwiftUI

struct ResetPasswordView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 26) {
            IconButton(
                imageSystemName: "arrow.left",
                action: {
                    withAnimation(.spring()) {
                        viewModel.authenticationMode = .login
                    }
                }
            )
            
            Text("Redefinir sua senha")
                .collieFont(textStyle: .largeTitle)
            
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("Enviar e-mail")
                        .collieFont(textStyle: .regularText)
                    
                    CustomTextField("E-mail", text: $viewModel.currentUser.email)  {
                        return viewModel.currentUser.isValidEmail() || viewModel.currentUser.email == ""
                    }
                }
            }
            
            Spacer()
            
            DefaultButton(
                label: "Enviar e-mail",
                backgroundColor: .collieAzulEscuro,
                isButtonDisabled: !viewModel.currentUser.isValidEmail(),
                handleSend: {
                    viewModel.resetPassword()
                    withAnimation(.spring()) {
                        viewModel.authenticationMode = .login
                    }
                }
            )
            .frame(maxWidth: 400)
            
        }
        .foregroundColor(.black)
        .padding(.horizontal, 60)
        .padding(.vertical, 42)
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
