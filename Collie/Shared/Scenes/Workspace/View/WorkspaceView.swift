import SwiftUI

struct WorkspaceView: View {
    @ObservedObject var viewModel = WorkspaceViewModel()
    @EnvironmentObject var rootViewModel: RootViewModel
//    @State var showCreateWorkspaceForm = false
//    @State var showSidebar = false
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
                }
//                VStack {
//                    VStack {
//                        if viewModel.selectedWorkspace != nil {
//                            loadingWorkspace
//                        } else if showCreateWorkspaceForm {
//                            createWorkspaceForm
//                        } else {
//                            if viewModel.workspacesAvailable.isEmpty {
//                                noWorkspacesFoundView
//                            } else {
//                                workspacesListView
//                            }
//                        }
//                    }
//                }
                
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.collieBranco.ignoresSafeArea())
            .onAppear {
                // WARNING - GAMBIARRA CABULOSA
                // TODO: Dependecy injection
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
    
    
    var createWorkspaceForm: some View {
        VStack {
            VStack {
                Text("Criar Workspace")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(.black)
                
                Spacer()
                
                VStack {
                    HStack {
                        Text("Qual é o nome da sua empresa?")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.black)
                        Spacer()
                    }
                    
                    SimpleTextField(text: $viewModel.workspaceName, showPlaceholderWhen: viewModel.workspaceName.isEmpty, placeholderText: "Nome da empresa")
                        .modifier(CustomBorder())
                }
                .frame(width: 400)
                
                Spacer()
            }
            .padding(.vertical)
            .frame(height: 400)
            .modifier(WorkspaceCardModifier())
            
            WorkspaceButton(title: "salvar", action: {
                viewModel.createNewWorkspace()
            })
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
                Text("Carregando...")
                    .font(.system(size: 18, weight: .medium))
//                NavigationLink("", isActive: $showSidebar, destination: {
//                    BusinessManagerSidebarView()
//                })
//                .opacity(0)
            }
            
        }
        .frame(maxWidth: NSScreen.main!.frame.width > 600 ? (NSScreen.main!.frame.width * 0.6) : .infinity)
    }
    
    var noWorkspacesFoundView: some View {
        VStack {
            VStack(spacing: 16) {
                Text("Ih, parece que você ainda não faz parte de nenhum workspace.")
                    .font(.system(size: 34, weight: .bold))
                Text("Workspaces auxiliam no gerenciamento do time da sua empresa, crie e gerencie seu espaço já!")
                    .font(.system(size: 16, weight: .regular))
            }
            .foregroundColor(.black)
            .multilineTextAlignment(.center)
            .frame(height: 400)
            .modifier(WorkspaceCardModifier())
            
            WorkspaceButton(title: "criar workspace", action: {
                viewModel.workspaceViewState = .createForm
            })
        }
    }
    
    var workspacesListView: some View {
        VStack {
            VStack {
                VStack(spacing: 16) {
                    Text("Selecione seu workspace e encontre seu time")
                        .font(.system(size: 34, weight: .bold))
                    Text("Workspaces auxiliam no gerenciamento no time da sua empresa, crie e gerencie seu espaço já!")
                        .font(.system(size: 16, weight: .regular))
                }
                .foregroundColor(.black)
                .padding(.bottom, 32)
                
                if viewModel.workspacesAvailable.count > 3 {
                    ScrollView(.horizontal) {
                        HStack(spacing: 32) {
                            Spacer()
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
                } else {
                    HStack(spacing: 32) {
                        Spacer()
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
            .modifier(WorkspaceCardModifier())
            
            WorkspaceButton(title: "criar novo workspace") {
                viewModel.workspaceViewState = .createForm
            }
        }
    }
}

struct WorkspaceView_Previews: PreviewProvider {
    static var previews: some View {
        WorkspaceView()
    }
}
