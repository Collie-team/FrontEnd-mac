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
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView(.vertical, showsIndicators: true) {
                VStack(spacing: 0) {
                    HStack(alignment: .bottom) {
                        Text("Acompanhamento")
                            .collieFont(textStyle: .largeTitle)
                            .foregroundColor(Color.black)
                        
                        Spacer()
                        
                        InviteUserButton {
                            viewModel.newUserPopupEnabled = true
                        }
                        
//                        VStack(alignment: .trailing) {
//                            HStack {
//                                Image(systemName: "bell")
//                                    .foregroundColor(Color.collieRoxo)
//                                    .collieFont(textStyle: .subtitle)
//                                    .padding()
//                                    .overlay(
//                                        ZStack {
//                                            Circle()
//                                                .frame(width: 14, height: 14)
//                                                .foregroundColor(.red)
//                                            Text("4")
//                                                .collieFont(textStyle: .regularText)
//                                        }
//                                        .offset(x: 7, y: -7)
//                                    )
//                                if rootViewModel.currentUser.imageURL != "", let url = URL(string: rootViewModel.currentUser.imageURL) {
//                                    AnimatedImage(url: url)
//                                        .resizable()
//                                        .aspectRatio(contentMode: .fit)
//                                        .frame(width: 36, height: 36)
//                                        .cornerRadius(18)
//                                    .onTapGesture {
//                                        viewModel.profileDetailsShowing.toggle()
//                                    }
//                                    .popover(isPresented: $viewModel.profileDetailsShowing,
//                                             attachmentAnchor: .point(.bottomTrailing),   // here !
//                                             arrowEdge: .bottom) {
//                                        ProfilePopUpView(name: rootViewModel.currentUser.name, jobDescription: rootViewModel.currentUser.jobDescription, email: rootViewModel.currentUser.email, imageURL: rootViewModel.currentUser.imageURL, handleLogout: {
//                                            rootViewModel.navigationState = .authentication
//                                        }, navigateToProfileView: {
//                                            // TODO: Resetar rootView, e outras variaveis
//                                            businessSidebarViewModel.selectedItem = .init(option: .profile)
//                                        })
//                                    }
//                                } else {
//                                    ZStack {
//                                        Circle()
//                                            .foregroundColor(.white)
//                                            .frame(width: 36, height: 36)
//                                        Text(rootViewModel.currentUser.name.split(separator: " ")[0].description.uppercased().prefix(1) + rootViewModel.currentUser.name.split(separator: " ")[1].description.uppercased().prefix(1))
//                                            .collieFont(textStyle: .regularText)
//                                    }
//                                    .onTapGesture {
//                                        viewModel.profileDetailsShowing.toggle()
//                                    }
//                                    .popover(isPresented: $viewModel.profileDetailsShowing,
//                                             attachmentAnchor: .point(.bottomTrailing),   // here !
//                                             arrowEdge: .bottom) {
//                                        ProfilePopUpView(name: rootViewModel.currentUser.name, jobDescription: rootViewModel.currentUser.jobDescription, email: rootViewModel.currentUser.email, imageURL: rootViewModel.currentUser.imageURL, handleLogout: {
//                                            rootViewModel.navigationState = .authentication
//                                        }, navigateToProfileView: {
//                                            // TODO: Resetar rootView, e outras variaveis
//                                            businessSidebarViewModel.selectedItem = .init(option: .profile)
//                                        })
//                                    }
//                                }
//                            }
//                        }
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
        .frame(maxWidth: .infinity)
        .frame(maxHeight: .infinity)
        .background(Color.collieBrancoFundo.ignoresSafeArea())
        .navigationTitle("Acompanhamento do time")
        .onAppear() {
            viewModel.fetchUsers(business: rootViewModel.businessSelected)
        }
        .popover(isPresented: $viewModel.newUserPopupEnabled) {
            NewUserFormsView()
        }
    }
}

struct TeamListView_Previews: PreviewProvider {
    static var previews: some View {
        TeamListView()
    }
} 
