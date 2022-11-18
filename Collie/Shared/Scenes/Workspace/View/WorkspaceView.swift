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
                    LoadingView()
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
                viewModel.workspacesAvailable = rootViewModel.availableBusiness
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
    
    var loginWorkspace: some View {
        VStack {
            VStack {
                ZStack {
                    Text("Entrar Workspace")
                        .font(.system(size: 30, weight: .bold))
                    .foregroundColor(.black)
                    HStack {
                        Button(action: {
                            if viewModel.workspacesAvailable.isEmpty {
                                viewModel.workspaceViewState = .noWorkspacesFound
                            } else {
                                viewModel.workspaceViewState = .workspaceList
                            }
                        }) {
                            Image(systemName: "arrow.left")
                        }
                        Spacer()
                    }
                }
                
                VStack {
                    Text("Digite o código do workspace enviado pelo e-mail:")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                    if viewModel.codeResponse != .none {
                        Text("\(Image(systemName: viewModel.codeResponse == .error ? "xmark.octagon.fill" : "checkmark.seal.fill")) \(viewModel.codeResponse.rawValue)")
                            .font(.system(size: 12))
                            .foregroundColor(viewModel.codeResponse == .error ? Color.collieVermelho : Color.collieVerde)
                    }
                    
                    SimpleTextField(text: $viewModel.workspaceCode, showPlaceholderWhen: viewModel.workspaceCode.isEmpty, placeholderText: "Código do workspace")
                        .modifier(CustomBorder())
                }
                .frame(width: 400)
            }
            .padding(.vertical, 50)
            .modifier(WorkspaceCardModifier())
            
            WorkspaceButton(title: "Entrar", action: {
                viewModel.loginWorkspace(user: rootViewModel.currentUser) { business, userBusiness in
                    rootViewModel.availableBusiness = business
                    rootViewModel.availableBusinessUsers = userBusiness
                }
            })
            .disabled(viewModel.workspaceCode.isEmpty)
        }
    }
    
    var createWorkspaceForm: some View {
        VStack {
            VStack {
                ZStack {
                    Text("Criar Workspace")
                        .font(.system(size: 30, weight: .bold))
                    .foregroundColor(.black)
                    HStack {
                        Button(action: {
                            if viewModel.workspacesAvailable.isEmpty {
                                viewModel.workspaceViewState = .noWorkspacesFound
                            } else {
                                viewModel.workspaceViewState = .workspaceList
                            }
                        }) {
                            Image(systemName: "arrow.left")
                        }
                        Spacer()
                    }
                }
                
                VStack {
                    HStack {
                        Text("Qual é o nome do workspace?")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.black)
                        Spacer()
                    }
                    
                    SimpleTextField(text: $viewModel.workspaceName, showPlaceholderWhen: viewModel.workspaceName.isEmpty, placeholderText: "Nome do workspace")
                        .modifier(CustomBorder())
                }
                .frame(width: 400)
                
                WorkspaceButton(title: "criar workspace", action: {
                    viewModel.createNewWorkspace()
                })
            }
            .padding(.vertical, 50)
            .modifier(WorkspaceCardModifier())
            .disabled(viewModel.workspaceName.isEmpty)
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
                    .font(.system(size: 18, weight: .medium))
            }
            
        }
        .frame(maxWidth: NSScreen.main!.frame.width > 600 ? (NSScreen.main!.frame.width * 0.6) : .infinity)
    }
    
    var noWorkspacesFoundView: some View {
        VStack {
            VStack {
                VStack(spacing: 16) {
                    Text("Olá! Como você deseja ingressar na plataforma?")
                        .font(.system(size: 34, weight: .bold))
                        .lineLimit(1)
                    Text("A plataforma é dividida em workspaces, que é a sua empresa no espaço virtual!")
                        .font(.system(size: 16, weight: .regular))
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
                            .font(.system(size: 17))
                            .lineLimit(2)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: 400)
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
                            .font(.system(size: 17))
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
        VStack {
            VStack {
                VStack(spacing: 16) {
                    Text("Olá! Como você deseja começar?")
                        .font(.system(size: 34, weight: .bold))
                        .lineLimit(1)
                    Text("Workspaces são a representação virtual da empresa! Se você está entrando em um novo trabalho entre com o código fornecido pela empresa. \nCaso você esteja implementando a Collie na sua empresa, crie um workspace!")
                        .font(.system(size: 16, weight: .regular))
                        .multilineTextAlignment(.center)
                }
                .foregroundColor(.black)
                .padding(.bottom, 32)
                
                ScrollView(.horizontal) {
                    HStack(spacing: 16) {
                        Spacer()
                        WorkspaceOptionView(systemImageName: "link.badge.plus", title: "Entrar através de um código") {
                            viewModel.workspaceViewState = .loginWorkspace
                        }
                        
                        WorkspaceOptionView(systemImageName: "plus", title: "Criar workspace") {
                            viewModel.workspaceViewState = .createForm
                        }
                        
                        ForEach(viewModel.workspacesAvailable) { business in
                            BusinessCard(business: business)
                                .onTapGesture {
                                    viewModel.selectWorkspace(business)
                                }
                                .contentShape(Rectangle())
                        }
                        Spacer()
                    }
                    .padding(2)
                }
            }
            .padding(.vertical, 50)
            .modifier(WorkspaceCardModifier())
        }
    }
}

struct WorkspaceView_Previews: PreviewProvider {
    static var previews: some View {
        WorkspaceView()
    }
}
