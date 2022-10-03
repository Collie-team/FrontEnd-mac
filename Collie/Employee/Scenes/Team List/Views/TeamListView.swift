import SwiftUI

enum ListComponents: CGFloat {
    case tasks = 0.1
    case progress = 0.3
    case phase = 0.17
    case journey = 0.12
    
    static func alignWith(component: ListComponents) -> CGFloat {
        return component.rawValue
    }
}

struct TeamListView: View {
    @ObservedObject var viewModel = TeamListViewModel()
    
    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: true) {
                VStack {
                    HStack(alignment: .bottom) {
                        VStack(alignment: .leading) {
                            Text("Acompanhamento")
                                .font(.system(size: 34, weight: .bold, design: .default))
                                .foregroundColor(Color.black)
                                .padding(.bottom, 12)
                            Text("Faça um acompanhamento geral do seu time :P")
                                .font(.system(size: 16, weight: .semibold, design: .rounded))
                                .foregroundColor(Color.black.opacity(0.6))
                        }
                        Spacer()
                        VStack(alignment: .trailing) {
                            HStack {
                                Image(systemName: "bell")
                                    .foregroundColor(Color.collieRoxo)
                                    .font(.system(size: 16, weight: .semibold))
                                    .padding()
                                    .overlay(
                                        ZStack {
                                            Circle()
                                                .frame(width: 14, height: 14)
                                                .foregroundColor(.red)
                                            Text("4")
                                                .font(.system(size: 10))
                                        }
                                        .offset(x: 7, y: -7)
                                    )
                                ZStack {
                                    Circle()
                                        .foregroundColor(.gray)
                                        .frame(width: 36, height: 36)
                                    Text("A")
                                        .font(.system(size: 14))
                                }
                            }
                            HStack {
                                Button(action: {
                                    viewModel.newUserPopupEnabled = true
                                }) {
                                    HStack {
                                        Image(systemName: "plus.circle.fill")
                                        Text("Adicionar Usuários")
                                    }
                                    .foregroundColor(.white)
                                    .padding(8)
                                    .padding(.horizontal,8)
                                }
                                .buttonStyle(.plain)
                                .background(Color.collieRoxo)
                                .cornerRadius(8)
                                .contentShape(Rectangle())
                                
                                Button(action: {}) {
                                    HStack {
                                        Text("Filtros")
                                            .padding(.trailing,8)
                                        Image(systemName: "chevron.down")
                                    }
                                    .foregroundColor(.gray)
                                    .padding(8)
                                }
                                .buttonStyle(.plain)
                                .background(Color.white)
                                .cornerRadius(8)
                            }
                        }
                    }
                    .padding(.bottom)
                    
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
                                        Text("Jornada")
                                    }
                                    .frame(width: geometry.size.width * ListComponents.alignWith(component: .journey))
                                    
                                    VStack {
                                        Text("Fase")
                                    }
                                    .frame(width: geometry.size.width * ListComponents.alignWith(component: .phase))
                                    
                                    VStack {
                                        Text("Progresso")
                                    }
                                    .frame(width: geometry.size.width * ListComponents.alignWith(component: .progress))
                                    
                                    VStack {
                                        Text("Tarefas")
                                    }
                                    .frame(width: geometry.size.width * ListComponents.alignWith(component: .tasks))
//                                    .border(Color.blue)
                                }
                                .frame(height: geometry.size.height)
                            }
//                            .border(Color.black)
                            Button(action: {}) {
                                Image(systemName: "xmark")
                                    .font(.system(size: 13))
                                    .foregroundColor(.gray)
                            }
                            .buttonStyle(.plain)
                            .disabled(true)
                            .opacity(0)
                        }
                        .foregroundColor(.black)
                        .font(.system(size: 20, weight: .semibold))
                        .padding()
                        
                        ForEach(viewModel.sampleUsers) { user in
                            HStack(spacing: 0) {
                                ZStack {
                                    Circle()
                                        .frame(width: 48, height: 48)
                                        .foregroundColor(.collieRosaClaro)
                                    Text("AA")
                                        .font(.system(size: 16, weight: .bold, design: .default))
                                }
                                .padding(.trailing)
                                
                                GeometryReader { geometry in
                                    HStack(alignment: .center, spacing: 0) {
                                        Text("\(user.name)")
                                        
                                        Spacer()
                                        
                                        VStack {
                                            Text("iOS Dev")
                                                .font(.system(size: 17))
                                        }
                                        .frame(width: geometry.size.width * ListComponents.alignWith(component: .journey))
                                        
                                        VStack {
                                            Text("Pré-Onboarding")
                                                .font(.system(size: 15))
                                        }
                                        .frame(width: geometry.size.width * ListComponents.alignWith(component: .phase))
                                        
                                        VStack {
                                            ProgressBarView()
                                        }
                                        .frame(width: geometry.size.width * ListComponents.alignWith(component: .progress))
                                        
                                        VStack {
                                            Text("3/14")
                                                .font(.system(size: 17))
                                        }
                                        .frame(width: geometry.size.width * ListComponents.alignWith(component: .tasks))
                                        
                                    }
                                }
                                .foregroundColor(.black)
                                
                                    
                                Button(action: {}) {
                                    Image(systemName: "xmark")
                                        .font(.system(size: 13))
                                        .foregroundColor(.gray)
                                }
                                .buttonStyle(.plain)
                            }
                            .padding()
                            .frame(height: 60)
                            .background(Color.white)
                            .cornerRadius(8)
                        }
                    }
                    
                    Spacer()
                }
            }
        }
        .padding(.horizontal, 60)
        .padding(.vertical, 32)
        .frame(maxWidth: .infinity)
        .frame(maxHeight: .infinity)
        .background(Color.collieBranco.ignoresSafeArea())
        .navigationTitle("Acompanhamento do time")
        .onAppear() {
            viewModel.fetchUsers()
        }
        .popover(isPresented: $viewModel.newUserPopupEnabled) {
            NewUserFormsView()
                .environmentObject(viewModel)
        }
    }
}

struct TeamListView_Previews: PreviewProvider {
    static var previews: some View {
        TeamListView()
    }
} 
