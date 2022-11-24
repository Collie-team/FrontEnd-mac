import SwiftUI

struct WorkspaceView: View {
    // State to prevent reloading
    @StateObject var viewModel = WorkspaceViewModel()
    @EnvironmentObject var rootViewModel: RootViewModel
    
    var body: some View {
        ZStack {
            VStack {
                Image("logoCollieBlack")
                    .resizable()
                    .aspectRatio(204/41.42, contentMode: .fit)
                    .frame(maxWidth: 204)
                    .padding(.vertical, 32)
                
                Spacer()
                
                switch viewModel.workspaceViewState {
                case .loading:
                    LoadingIndicator()
                case .loadingWorkspace:
                    loadingWorkspace
                case .createForm:
                    createWorkspaceForm
                case .noWorkspacesFound:
                    noWorkspacesFoundView
                case .workspaceList:
                    workspacesListView
                case .loginWorkspace:
                    loginWorkspace
                }
                
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.collieBranco.ignoresSafeArea())
            .onAppear {
                rootViewModel.fetchAvailableBusinesses {
                    viewModel.workspacesAvailable = rootViewModel.availableBusinesses
                    viewModel.newWorkspaceHandler = rootViewModel.createWorkspace
                    viewModel.handleWorkspaceSelection = rootViewModel.handleWorkspaceSelection
                    if viewModel.workspacesAvailable.isEmpty {
                        viewModel.workspaceViewState = .noWorkspacesFound
                    } else {
                        viewModel.workspaceViewState = .workspaceList
                    }
                }
            }
        }
    }
    
    var loginWorkspace: some View {
        VStack {
            VStack {
                HStack {
                    Button(action: {
                        if viewModel.workspacesAvailable.isEmpty {
                            viewModel.workspaceViewState = .noWorkspacesFound
                        } else {
                            viewModel.workspaceViewState = .workspaceList
                        }
                    }) {
                        Image(systemName: "arrow.left")
                            .collieFont(textStyle: .smallTitle)
                            .frame(width: 48, height: 48)
                            .modifier(CustomBorder())
                            .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                    
                    Spacer()
                }
                
                VStack(spacing: 16) {
                    Text("Qual é o código da sua empresa?")
                        .collieFont(textStyle: .title)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                    
                    if viewModel.codeResponse != .none {
                        Text("\(Image(systemName: viewModel.codeResponse == .error ? "xmark.octagon.fill" : "checkmark.seal.fill")) \(viewModel.codeResponse.rawValue)")
                            .collieFont(textStyle: .regularText)
                            .foregroundColor(viewModel.codeResponse == .error ? Color.collieVermelho : Color.collieVerde)
                    }
                    
                    SimpleTextField(text: $viewModel.workspaceCode, showPlaceholderWhen: viewModel.workspaceCode.isEmpty, placeholderText: "Código do workspace")
                        .modifier(CustomBorder())
                        .padding(.bottom)
                    
                    DefaultButton(
                        label: "entrar no workspace",
                        backgroundColor: .collieAzulEscuro,
                        isButtonDisabled: viewModel.workspaceCode.isEmpty,
                        handleSend: {
                            viewModel.loginWorkspace(user: rootViewModel.currentUser) { business, userBusiness in
                                rootViewModel.availableBusinesses = business
                                rootViewModel.availableBusinessUsers = userBusiness
                            }
                        }
                    )
                }
                .frame(width: 450)
            }
            .padding(.bottom, 50)
            .modifier(WorkspaceCardModifier())
        }
    }
    
    var createWorkspaceForm: some View {
        VStack {
            VStack {
                HStack {
                    Button(action: {
                        if viewModel.workspacesAvailable.isEmpty {
                            viewModel.workspaceViewState = .noWorkspacesFound
                        } else {
                            viewModel.workspaceViewState = .workspaceList
                        }
                    }) {
                        Image(systemName: "arrow.left")
                            .collieFont(textStyle: .smallTitle)
                            .frame(width: 48, height: 48)
                            .modifier(CustomBorder())
                            .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                    
                    Spacer()
                }
                
                VStack(spacing: 16) {
                    Text("Qual o nome da sua empresa ou equipe?")
                        .collieFont(textStyle: .title)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                    
                    SimpleTextField(text: $viewModel.workspaceName, showPlaceholderWhen: viewModel.workspaceName.isEmpty, placeholderText: "Nome do workspace")
                        .modifier(CustomBorder())
                        .padding(.bottom)
                    
                    DefaultButton(
                        label: "criar workspace",
                        backgroundColor: .collieAzulEscuro,
                        isButtonDisabled: viewModel.workspaceName.isEmpty,
                        handleSend: {
                            viewModel.createNewWorkspace()
                        }
                    )
                }
                .frame(width: 450)
            }
            .padding(.bottom, 50)
            .modifier(WorkspaceCardModifier())
        }
    }
    
    var loadingWorkspace: some View {
        VStack {
            if let business = viewModel.selectedWorkspace {
                LoadingBusinessCard(business: business)
                    .padding(.bottom)
            }
            
            VStack(spacing: 32) {
                LoadingIndicator()
                    .frame(width: 100, height: 100)
                Text("Carregando...")
                    .collieFont(textStyle: .smallTitle)
            }
            
        }
        .frame(maxWidth: NSScreen.main!.frame.width > 600 ? (NSScreen.main!.frame.width * 0.6) : .infinity)
    }
    
    var noWorkspacesFoundView: some View {
        VStack {
            VStack {
                VStack(spacing: 16) {
                    Text("Olá! Como você deseja ingressar na plataforma?")
                        .collieFont(textStyle: .largeTitle)
                        .lineLimit(1)
                    Text("A plataforma é dividida em workspaces, que é a sua empresa no espaço virtual!")
                        .collieFont(textStyle: .regularText)
                        .lineLimit(1)
                }
                .padding(.bottom, 40)
                
                HStack(alignment: .top) {
                    Spacer()
                    
                    VStack(spacing: 20) {
                        WorkspaceOptionView(systemImageName: "link.badge.plus", title: "Entrar através de um código") {
                            viewModel.workspaceViewState = .loginWorkspace
                        }
                        
                        Text("Se você está entrando em um novo trabalho entre com o código fornecido pela empresa.")
                            .foregroundColor(.black)
                            .collieFont(textStyle: .regularText)
                            .lineLimit(2)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: 450)
                            .minimumScaleFactor(0.5)
                    }
                    
                    Spacer()
                    
                    RoundedRectangle(cornerRadius: 50)
                        .frame(width: 2)
                        .frame(maxHeight: 275)
                        .foregroundColor(.collieCinzaBorda)
                    
                    Spacer()
                    
                    VStack(spacing: 20) {
                        WorkspaceOptionView(systemImageName: "plus", title: "Criar workspace") {
                            viewModel.workspaceViewState = .createForm
                        }
                        
                        Text("Caso você esteja implementando a Collie na sua empresa, crie um workspace!")
                            .foregroundColor(.black)
                            .collieFont(textStyle: .regularText)
                            .lineLimit(2)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: 400)
                            .minimumScaleFactor(0.5)
                    }
                    
                    Spacer()
                }
            }
            .foregroundColor(.black)
            .multilineTextAlignment(.center)
            .padding(.vertical, 50)
            .modifier(WorkspaceCardModifier())
        }
    }
    
    var workspacesListView: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                VStack(spacing: 16) {
                    Text("Olá! Como você deseja começar?")
                        .collieFont(textStyle: .largeTitle)
                        .lineLimit(1)
                    Text("Workspaces são a representação virtual da empresa! Se você está entrando em um novo trabalho entre com o código fornecido pela empresa. Caso você esteja implementando a Collie na sua empresa, crie um workspace!")
                        .collieFont(textStyle: .regularText)
                        .lineLimit(2)
                        .multilineTextAlignment(.center)
                        .frame(minHeight: 60)
                }
                .foregroundColor(.black)
                .padding(.bottom, 32)
                
                ScrollView(.horizontal) {
                    HStack(spacing: 16) {
                        Spacer()
                        WorkspaceOptionView(systemImageName: "link.badge.plus", title: "Entrar através de um código") {
                            viewModel.workspaceViewState = .loginWorkspace
                        }
                        .padding(.leading, 32)
                        
                        WorkspaceOptionView(systemImageName: "plus", title: "Criar workspace") {
                            viewModel.workspaceViewState = .createForm
                        }
                        
                        ForEach(viewModel.workspacesAvailable) { business in
                            WorkspaceCard(business: business)
                                .onTapGesture {
                                    viewModel.selectWorkspace(business)
                                }
                                .contentShape(Rectangle())
                        }
                        Spacer()
                    }
                    .padding(2)
                    .padding(.bottom, 24)
                }
                .frame(maxHeight: 300)
                .padding(.horizontal, -32)
            }
            .padding(.vertical, 50)
            .modifier(WorkspaceCardModifier())
        }
    }
}

//struct WorkspaceView_Previews: PreviewProvider {
//    static var previews: some View {
//        WorkspaceView()
//    }
//}
