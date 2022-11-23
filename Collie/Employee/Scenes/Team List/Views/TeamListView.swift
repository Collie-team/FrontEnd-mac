import SwiftUI
import SDWebImageSwiftUI

enum ListComponents: CGFloat {
    case tasks = 0.1
    case progress = 0.2
    case contact = 0.32
    case journey = 0.24
    case name = 0.4
    case email = 0.27
    case date = 0.13
    case role = 0.17
    
    static func alignWith(component: ListComponents) -> CGFloat {
        return component.rawValue
    }
}

struct TeamListView: View {
    @StateObject var viewModel = TeamListViewModel()
    @EnvironmentObject var businessSidebarViewModel: BusinessSidebarViewModel
    @EnvironmentObject var rootViewModel: RootViewModel
    
    @State var showEmailSendConfirmation = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                ScrollView(.vertical, showsIndicators: true) {
                    VStack(spacing: 0) {
                        HStack(alignment: .bottom, spacing: 16) {
                            Text("Acompanhamento")
                                .collieFont(textStyle: .largeTitle)
                                .foregroundColor(Color.black)
                            
                            InviteUserButton {
                                viewModel.newUserPopupEnabled = true
                            }
                            
                            Spacer()
                            
                            TopUserProfileIcon {
                                if let profileItem = businessSidebarViewModel.sidebarItens.first(where: { $0.option == .profile}) {
                                    businessSidebarViewModel.selectedItem = profileItem
                                }
                            }
                        }
                        .padding(.bottom, 32)
                        
                        // LISTA

                        VStack(alignment: .leading) {
                            HStack(spacing: 0) {
                                ZStack {
                                    Circle()
                                        .frame(width: 48, height: 48)
                                }
                                .padding(.trailing)
                                .opacity(0)
                                
                                GeometryReader { geometry in
                                    HStack(alignment: .center, spacing: 0) {
                                        Text("Nome")
                                        Spacer()
                                        
                                        VStack {
                                            Text("Contato")
                                        }
                                        .frame(width: geometry.size.width * ListComponents.alignWith(component: .contact))
                                        
                                        VStack {
                                            Text("Jornada")
                                        }
                                        .frame(width: geometry.size.width * ListComponents.alignWith(component: .journey))
                                        
                                        
                                        VStack() {
                                            HStack {
                                                Text("Progresso")
                                                Spacer()
                                            }
                                        }
                                        .frame(width: geometry.size.width * ListComponents.alignWith(component: .progress))
                                        
                                        VStack {
                                            Text("Tarefas")
                                        }
                                        .frame(width: geometry.size.width * ListComponents.alignWith(component: .tasks))
                                        
                                    }
                                    .frame(height: geometry.size.height)
                                }
                            }
                            .foregroundColor(.black)
                            .collieFont(textStyle: .smallTitle)
                            .padding()
                            
                            if viewModel.teamListUsers.isEmpty {
                                HStack {
                                    Spacer()
                                    LoadingIndicator()
                                    Spacer()
                                }
                            } else {
                                ForEach(viewModel.teamListUsers) { teamListUser in
                                    TeamListUserCell(teamListUser: teamListUser)
                                }
                            }
                        }
                        
                        Spacer()
                    }
                }
            }
            .padding(.horizontal, 32)
            .padding(.top, 32)
            .padding(.bottom)
            
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
        .frame(maxWidth: .infinity)
        .frame(maxHeight: .infinity)
        .background(Color.collieBrancoFundo.ignoresSafeArea())
        .navigationTitle("Acompanhamento do time")
        .onAppear() {
            viewModel.fetchUsers(business: rootViewModel.businessSelected)
        }
        .alert(isPresented: $showEmailSendConfirmation) {
            Alert(
                title: Text("O convite foi enviado por e-mail com sucesso!"),
                message: Text("Agora é só aguardar o novo funcionário entrar no workspace."),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

struct TeamListView_Previews: PreviewProvider {
    static var previews: some View {
        TeamListView()
    }
} 
