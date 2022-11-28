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
        switch viewModel.teamListViewState {
        case .teamList:
            teamList
        case .inspectView:
            InspectView(
                viewModel: InspectViewModel(
                    business: rootViewModel.businessSelected,
                    journey: rootViewModel.inspectingJourney,
                    businessUser: rootViewModel.inspectingBusinessUser!,
                    user: rootViewModel.inspectingUser!),
                backAction: {
                    viewModel.teamListViewState = .teamList
                    viewModel.teamListUsers = []
                })
        }
    }
    
    var teamList: some View {
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
                                ForEach(viewModel.teamListUsers.filter({$0.role == .employee})) { teamListUser in
                                    TeamListUserCell(teamListUser: teamListUser)
                                        .onTapGesture {
                                            if teamListUser.userJourneys.count > 1 {
                                                rootViewModel.configureEmployeeInspection(userId: teamListUser.userId, journeyId: teamListUser.userJourneys[0].id) {
                                                    viewModel.teamListViewState = .inspectView
                                                }
                                            } else {
                                                rootViewModel.configureEmployeeInspection(userId: teamListUser.userId, journeyId: teamListUser.userJourneys[0].id) {
                                                    viewModel.teamListViewState = .inspectView
                                                }
                                            }
                                        }
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
        .overlay(
            VStack {
                Spacer()
                HStack{
                    Spacer()
                    LoadingIndicator()
                        .opacity(rootViewModel.loadingInspection ? 1 : 0)
                    Spacer()
                }
                Spacer()
            }
        )
    }
}

struct TeamListView_Previews: PreviewProvider {
    static var previews: some View {
        TeamListView()
    }
} 
