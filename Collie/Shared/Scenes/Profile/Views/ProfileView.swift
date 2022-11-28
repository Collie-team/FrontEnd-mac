import SwiftUI
import SDWebImageSwiftUI

struct ProfileView: View {
    @EnvironmentObject var rootViewModel: RootViewModel
    @StateObject var viewModel = ProfileViewModel()
    @State var showEmailSendConfirmation = false
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 0) {
                HStack {
                    Text("Perfil")
                        .collieFont(textStyle: .largeTitle)
                        .foregroundColor(Color.black)
                    
                    Spacer()
                }
                .padding(.bottom, 32)
                
            VStack(spacing: 16) {
                HStack(alignment: .top, spacing: 36) {
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("Apresentação")
                                .collieFont(textStyle: .title)
                                .foregroundColor(.black)
                            Spacer()
                        }
                        Text("Esses dados são visiveis para todos os responsáveis dentro da plataforma.")
                            .collieFont(textStyle: .regularText)
                    }
                    .frame(maxWidth: 350)
                    
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        Text("Foto de Perfil")
                            .collieFont(textStyle: .regularText, textSize: 14)
                            .foregroundColor(.black)
                        
                        if let url = URL(string: rootViewModel.currentUser.imageURL) {
                            AnimatedImage(url: url)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 240, height: 240)
                                .cornerRadius(8)
                                .modifier(CustomBorder())
                                .overlay(
                                    ChangePhotoIcon()
                                )
                                .onTapGesture {
                                    rootViewModel.openFileSelectionForProfileImage()
                                }
                        } else {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Colors.getRandomSecondaryColor())
                                .frame(width: 240, height: 240)
                                .modifier(CustomBorder())
                                .overlay(
                                    ChangePhotoIcon()
                                )
                                .onTapGesture {
                                    rootViewModel.openFileSelectionForProfileImage()
                                }
                            }
                        }
                        
                        Spacer()
                        
                        if viewModel.editingMode {
                            EditingFormView(rootViewModelBusinessUser: $rootViewModel.currentBusinessUser, currentUser: rootViewModel.currentUser, editingMode: $viewModel.editingMode)
                                .preferredColorScheme(.dark)
                        } else {
                            DisplayFormView(rootViewModelUser: $rootViewModel.currentUser, rootViewModelBusinessUser: $rootViewModel.currentBusinessUser, currentUser: rootViewModel.currentUser, editingMode: $viewModel.editingMode)
                                .preferredColorScheme(.dark)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(32)
                    .background(Color.white)
                    .cornerRadius(12)
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                Text("Senha")
                                    .collieFont(textStyle: .title)
                                    .foregroundColor(.black)
                                Spacer()
                            }
                            Text("Altere sua senha e a deixe mais segura. Será necessário uma validação pelo e-mail utilizado na plataforma.")
                                .collieFont(textStyle: .regularText)
                        }
                        .frame(maxWidth: 350)
                        
                        Spacer()
                        
                        DefaultButtonWithLeftIcon(
                            label: "Enviar e-mail para alterar senha",
                            systemImageName: "envelope"
                        ) {
                            viewModel.resetPassword(email: rootViewModel.currentUser.email) {
                                showEmailSendConfirmation = true
                            }
                        }
                        .alert(isPresented: $showEmailSendConfirmation) {
                            Alert(
                                title: Text("O e-mail de redefinição de senha foi enviado com sucesso!"),
                                message: Text("Confira a caixa de spam :)"),
                                dismissButton: .default(Text("OK"))
                            )
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(32)
                    .background(Color.white)
                    .cornerRadius(12)
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                Text("Remover conta")
                                    .collieFont(textStyle: .title)
                                    .foregroundColor(.black)
                                Spacer()
                            }
                            Text("Ao remover sua conta, Todos os seus dados serão apagados da plataforma.")
                                .collieFont(textStyle: .regularText)
                        }
                        .frame(maxWidth: 350)
                        
                        Spacer()
                        
                        DestructiveButton(label: "Excluir conta") {
                            viewModel.showUserDeleteAlert = true
                            print(viewModel.showUserDeleteAlert)
                        }
                        .alert(isPresented: $viewModel.showUserDeleteAlert) {
                            Alert(
                                title: Text("Você realmente deseja apagar todos os seus dados?"),
                                message: Text("Essa ação é definitiva!"),
                                primaryButton: .cancel(),
                                secondaryButton: .destructive(Text("Deletar")) {
                                    rootViewModel.deleteUserData()
                                }
                            )
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(32)
                    .background(Color.white)
                    .cornerRadius(12)
                    
                    Spacer()
                }
            }
            .padding(.horizontal, 32)
            .padding(.top, 32)
            .padding(.bottom)
            .navigationTitle("Perfil")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.collieBrancoFundo.ignoresSafeArea())
//            .alert(isPresented: $viewModel.showUserDeleteAlert) {
//                Alert(
//                    title: Text("Você realmente deseja apagar todos os seus dados?"),
//                    message: Text("Essa ação é definitiva!"),
//                    primaryButton: .cancel(),
//                    secondaryButton: .destructive(Text("Deletar")) {
//                        rootViewModel.deleteUserData()
//                    }
//                )
//            }
//            .alert(isPresented: $showEmailSendConfirmation) {
//                Alert(
//                    title: Text("O e-mail de redefinição de senha foi enviado com sucesso!"),
//                    message: Text("Confira a caixa de spam :)"),
//                    dismissButton: .default(Text("OK"))
//                )
//            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.collieBrancoFundo.ignoresSafeArea())
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
