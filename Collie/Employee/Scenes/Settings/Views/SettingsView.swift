import SwiftUI
import UniformTypeIdentifiers
import SDWebImageSwiftUI

struct SettingsView: View {
    @StateObject var viewModel = SettingsViewModel()
    @EnvironmentObject var rootViewModel: RootViewModel
    @EnvironmentObject var businessSidebarViewModel: BusinessSidebarViewModel
    
    @State var showDeleteAlert = false
    @State var showEmailSendConfirmation = false
    @State var copyClicked = false
    
    var body: some View {
        ZStack {
            ScrollView(.vertical) {
                VStack(spacing: 0) {
                    HStack {
                        Text("Configurações")
                            .collieFont(textStyle: .largeTitle)
                            .foregroundColor(Color.black)
                        
                        Spacer()
                        
                        TopUserProfileIcon {
                            if let profileItem = businessSidebarViewModel.sidebarItens.first(where: { $0.option == .profile}) {
                                businessSidebarViewModel.selectedItem = profileItem
                            }
                        }
                    }
                    .padding(.bottom, 32)
                    
                    VStack(spacing: 16) {
                        HStack(alignment: .top, spacing: 36) {
                            VStack(alignment: .leading, spacing: 16) {
                                HStack {
                                    Text("Dados do workspace")
                                        .collieFont(textStyle: .title)
                                        .foregroundColor(.black)
                                    Spacer()
                                }
                                Text("Esses dados são visiveis para todos os usuários com acesso ao workspace.")
                                    .collieFont(textStyle: .regularText)
                            }
                            .frame(maxWidth: 350)
                            
                            Spacer()
                            
                            VStack(alignment: .leading) {
                                Text("Foto do workspace")
                                    .collieFont(textStyle: .regularText, textSize: 14)
                                    .foregroundColor(.black)
                                
                                if let url = URL(string: rootViewModel.businessSelected.imageURL!) {
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
                                            rootViewModel.openFileSelectionForBusinessImage()
                                        }
                                } else {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(Colors.getRandomSecondaryColor())
                                            .frame(width: 240, height: 240)
                                            .modifier(CustomBorder())
                                            .overlay(
                                                ChangePhotoIcon()
                                            )
                                            .onTapGesture {
                                                rootViewModel.openFileSelectionForBusinessImage()
                                            }
                                        }
                                        
                                    }
                                }
                                
                                Spacer()
                                
                                if viewModel.editingMode {
                                    BusinessEditingFormView(
                                        editingMode: $viewModel.editingMode,
                                        businessName: rootViewModel.businessSelected.name,
                                        handleBusinessNameSave: { newName in
                                            rootViewModel.businessSelected.name = newName
                                            rootViewModel.updateBusiness(rootViewModel.businessSelected, replaceBusiness: false)
                                        }
                                    )
                                    .preferredColorScheme(.dark)
                                    .environmentObject(rootViewModel)
                                } else {
                                    BusinessDisplayFormView(
                                        rootViewModelSelectedBusiness: $rootViewModel.businessSelected,
                                        currentBusiness: rootViewModel.businessSelected,
                                        editingMode: $viewModel.editingMode
                                    )
                                    .preferredColorScheme(.dark)
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding(32)
                            .background(Color.white)
                            .cornerRadius(12)
                        
                        HStack(alignment: .center, spacing: 32) {
                            VStack(alignment: .leading, spacing: 16) {
                                VStack(alignment: .leading, spacing: 10) {
                                    HStack {
                                        Text("Usuários ativos")
                                            .collieFont(textStyle: .title)
                                            .foregroundColor(.black)
                                        
                                        Spacer()
                                    }
                                    
                                    Text("Todos os usuários ativos na plataforma da sua empresa nesse momento.")
                                        .collieFont(textStyle: .regularText)
                                        .foregroundColor(.black)
                                }
                                
                                InviteUserButton {
                                    viewModel.newUserPopupEnabled = true
                                }
                            }
                            .padding(.bottom)
                            .frame(maxWidth: 350)
                            
                            VStack(alignment: .leading) {
                                HStack(alignment: .center, spacing: 0) {
                                    Circle()
                                        .frame(width: 40, height: 40)
                                        .opacity(0)
                                        .padding(.horizontal)
                                    
                                    GeometryReader { geometry in
                                        HStack(alignment: .top, spacing: 0) {
                                            Text("Nome")
            
                                            Spacer()
                                            
                                            VStack {
                                                Text("E-mail")
                                            }
                                            .frame(width: geometry.size.width * ListComponents.alignWith(component: .email))
                                            
                                            VStack {
                                                Text("Papel")
                                            }
                                            .frame(width: geometry.size.width * ListComponents.alignWith(component: .role))
                                        
                                            IconButton(imageSystemName: "trash", action: {})
                                                .opacity(0)
                                                .padding(.leading, 32)
                                        }
                                    }
                                    .padding(.trailing, 36)
                                }
                                .frame(height: 50)
                                .foregroundColor(.black)
                                .collieFont(textStyle: .smallTitle)
                                
                                ScrollView(.vertical) {
                                    VStack {
                                        if viewModel.modelList.isEmpty {
                                            HStack(alignment: .center) {
                                                Spacer()
                                                LoadingIndicator()
                                                Spacer()
                                            }
                                            .frame(maxHeight: .infinity)
                                        } else {
                                            ForEach($viewModel.modelList, id: \.self) { $model in
                                                SettingsUserCell(model: $model, workspaceAdmins: $viewModel.workspaceAdmins, workspaceUsers: $viewModel.workspaceUsers, handleUserDeletion: {
                                                   viewModel.selectedUserModel = model.userModel
                                                   self.showDeleteAlert = true
                                                }, handleRoleChange: { bUser, role in
                                                    var businessUser = bUser
                                                    businessUser.role = role
                                                    rootViewModel.updateBusinessUser(businessUser) { updatedBusinessUser in
                                                        viewModel.updateAdminCount(businessUser: updatedBusinessUser)
                                                    }
                                                })
                                            }
                                        }
                                    }
                                    .padding(.trailing, 20)
                                    .padding(.leading, 3)
                                    .padding(.vertical, 3)
                                    .padding(.bottom, 32)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .frame(maxHeight: 500)
                        .padding([.top, .horizontal], 32)
                        .background(Color.white)
                        .cornerRadius(12)
                        
                        HStack {
                            VStack(alignment: .leading ,spacing: 12) {
                                HStack {
                                    Text("Código do workspace")
                                        .collieFont(textStyle: .title)
                                        .foregroundColor(.black)
                                    
                                    Spacer()
                                }
                                Text("Esse é o código para que novos colaboradores entrem em seu workspace de maneira mais direta. A nova pessoa deve inserir o código após o login na tela de workspaces.")
                                    .collieFont(textStyle: .regularText)
                            }
                            .frame(maxWidth: 350)
                            
                            Spacer()
                            VStack {
                                Text("Clique no código para copiar")
                                    .collieFont(textStyle: .regularText)
                                ZStack {
                                    Text(viewModel.businessCode)
                                        .collieFont(textStyle: .title)
                                    HStack {
                                        Spacer()
                                        Image(systemName: "doc.on.doc")
                                            .collieFont(textStyle: .subtitle)
                                            .padding(.trailing, 16)
                                            .foregroundColor(copyClicked ? Color.collieVerde : .black)
                                    }
                                }
                                .frame(maxWidth: 340, maxHeight: 60)
                                .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(copyClicked ? Color.collieVerde : Color.collieCinzaBorda, lineWidth: 2)
                                    )
                                .onTapGesture {
                                    viewModel.copyToClipboard(text: viewModel.businessCode)
                                    copyClicked = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        self.copyClicked = false
                                    }
                                }
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .leading, spacing: 16) {
                                HStack {
                                    Text("Caso seja necessário impedir acesso pelo código, você pode gerar um novo código que substituirá o antigo.")
                                        .collieFont(textStyle: .regularText)
                                        .frame(maxWidth: 300)
                                    Spacer()
                                }
                                
                                SimpleButton(label: "Gerar novo código") {
                                    viewModel.redefineBusinessCode(businessId: rootViewModel.businessSelected.id)
                                }
                            }
                            .frame(maxWidth: 300)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(32)
                        .padding(.vertical, 32)
                        .background(Color.white)
                        .cornerRadius(12)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 32)
                .padding(.top, 32)
                .padding(.bottom)
            }
            
            if viewModel.newUserPopupEnabled {
                ZStack {
                    Color.black.opacity(0.5)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    NewUserFormsView(
                        handleClose: {
                            viewModel.newUserPopupEnabled = false
                        },
                        handleEmailSend: {
                            viewModel.newUserPopupEnabled = false
                            showEmailSendConfirmation = true
                        }
                    )
                    .environmentObject(viewModel)
                }
            }
        }
        .navigationTitle("Configurações")
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.collieBrancoFundo.ignoresSafeArea())
        .alert(isPresented: $showDeleteAlert) {
            Alert(
                title: Text("Você realmente deseja remover \(viewModel.selectedUserModel?.name ?? "")?"),
                message: Text("Essa ação é definitiva!"),
                primaryButton: .cancel(),
                secondaryButton: .destructive(Text("Deletar")) {
                    viewModel.removeBusinessUser()
                }
            )
        }
        .alert(isPresented: $showEmailSendConfirmation) {
            Alert(
                title: Text("O convite foi enviado por e-mail com sucesso!"),
                message: Text("Agora é só aguardar o novo funcionário entrar no workspace."),
                dismissButton: .default(Text("OK"))
            )
        }
        .onAppear {
            viewModel.fetchBusinessCode(businessId: rootViewModel.businessSelected.id)
            viewModel.fetchUsers(business: rootViewModel.businessSelected)
        }
    }
    
    var optionsSelector: some View {
        HStack(spacing: 32) {
            ForEach(SettingsOptions.allCases, id: \.self) { option in
                SettingsOptionView(option: option, isSelected: viewModel.isOptionSelected(option), handleSelect: {
                    viewModel.selectOption(option)
                })
            }
            Spacer()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
