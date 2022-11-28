import SwiftUI

struct AuthenticationView: View {
    var handleSingIn: (UserModel, String) -> ()
    @StateObject var viewModel = AuthenticationViewModel()
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Image("logoCollieBlack")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 204)
                Spacer()
            }
            .padding(.bottom, 64)
            .padding(.horizontal, 48)
            
            HStack(alignment: .top, spacing: 70) {
                VStack(alignment: .leading, spacing: 16) {
                    Text("A melhor maneira de gerenciar \nonboadings para novos colaboradores")
                        .collieFont(textStyle: .largeTitle)
                        .foregroundColor(Color.collieCinzaEscuro)
                    RoundedRectangle(cornerRadius: 50)
                        .fill(Color.collieRoxo)
                        .frame(width: 36, height: 5)
                    Text("Integre novos colaboradores com seus times, gerencie e \nacompanhe o processo de forma simples e prática.")
                        .collieFont(textStyle: .regularText, textSize: 21)
                        .foregroundColor(Color.collieCinzaEscuro)
                    Image("loginSplashImage")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                
                Spacer()
                
                if viewModel.loadingState == .fetchingData {
                    VStack {
                        Spacer()
                        LoadingIndicator()
                        Spacer()
                    }
                    .frame(maxWidth: min(NSScreen.main!.frame.width * 0.4, 530), maxHeight: NSScreen.main!.frame.height * 0.75)
                    .background(Color.white)
                    .cornerRadius(8)
                    .modifier(CustomBorder())
                    .padding(.bottom, 24)
                } else {
                    if viewModel.authenticationMode == .signup {
                        SignupView(completion: handleSingIn)
                            .frame(maxWidth: min(NSScreen.main!.frame.width * 0.4, 530), maxHeight: NSScreen.main!.frame.height * 0.75)
                            .environmentObject(viewModel)
                            .padding(.bottom, 24)
                    } else if viewModel.authenticationMode == .login {
                        LoginView(completion: handleSingIn)
                            .frame(maxWidth: min(NSScreen.main!.frame.width * 0.4, 530), maxHeight: NSScreen.main!.frame.height * 0.75)
                            .environmentObject(viewModel)
                            .padding(.bottom, 24)
                    } else if viewModel.authenticationMode == .passwordReset {
                        ResetPasswordView()
                            .frame(maxWidth: min(NSScreen.main!.frame.width * 0.4, 530), maxHeight: NSScreen.main!.frame.height * 0.75)
                            .environmentObject(viewModel)
                            .padding(.bottom, 24)
                    }
                }
            }
            .padding(.horizontal, 48)
            .onChange(of: viewModel.currentUser) { _ in
                viewModel.validateSingUpFields()
                viewModel.validateLoginFields()
            }
            
            Spacer()
        }
        .padding(.horizontal, 48)
        .padding(.top, 36)
        .background(Color.collieBranco)
        .onAppear {
            viewModel.loadingState = .waiting
        }
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView(handleSingIn: {_,_  in })
    }
}
