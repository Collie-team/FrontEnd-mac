import SwiftUI

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
                        HStack {
                            ZStack {
                                Circle()
                                    .frame(width: 48, height: 48)
                            }
                            .padding(.trailing)
                            .opacity(0)
                            ZStack(alignment: .center) {
                                HStack {
                                    Text("Nome")
                                    Spacer()
                                    Text("Tarefas")
                                    Button(action: {}) {
                                        Image(systemName: "xmark")
                                            .font(.system(size: 13))
                                            .foregroundColor(.gray)
                                    }
                                    .buttonStyle(.plain)
                                    .disabled(true)
                                    .padding()
                                    .opacity(0)
                                }

                                Text("Fase")
//                                    .offset(x: 240, y: 0)
                                Text("Jornada")
                                    .offset(x: -150, y: 0)
                                Text("Progresso")
                                    .offset(x: 100, y: 0)
                            }
                        }
                        .foregroundColor(.black)
                        .font(.system(size: 20, weight: .semibold))
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
                                
                                ZStack(alignment: .center) {
                                    HStack {
                                        Text("\(user.name)")
                                            .foregroundColor(.black)
                                        Spacer()
                                        Text("3/14")
                                            .font(.system(size: 17))
                                            .foregroundColor(.black)
                                            .padding(.horizontal)
                                        
                                        Button(action: {}) {
                                            Image(systemName: "xmark")
                                                .font(.system(size: 13))
                                                .foregroundColor(.gray)
                                        }
                                        .buttonStyle(.plain)
                                    }
                                    Text("iOS Dev")
                                        .font(.system(size: 17))
                                        .foregroundColor(.black)
                                        .offset(x: -150, y: 0)
                                    
                                    Text("Pré-Onboarding")
                                        .font(.system(size: 15))
                                        .foregroundColor(.black)
//                                    ProgressBarView()
//                                        .offset(x: 100, y: 0)
                                    
                                }
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
        .padding(.horizontal)
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






extension HorizontalAlignment {
    enum NameAlign: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            d[.leading]
        }
    }
    
    enum JourneyAlign: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            d[HorizontalAlignment.center]
        }
    }
    
    enum PhaseAlign: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            d[HorizontalAlignment.center]
        }
    }
    
    enum ProgressAlign: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            d[.leading]
        }
    }
    
    enum TaskAlign: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            d[.trailing]
        }
    }

    static let nameAlign = HorizontalAlignment(NameAlign.self)
    static let journeyAlign = HorizontalAlignment(JourneyAlign.self)
    static let phaseAlign = HorizontalAlignment(PhaseAlign.self)
    static let progressAlign = HorizontalAlignment(ProgressAlign.self)
    static let tasksAlign = HorizontalAlignment(TaskAlign.self)
}
