import SwiftUI

struct TeamListView: View {
    @ObservedObject var viewModel = TeamListViewModel()
    
    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: true) {
                VStack {
                    HStack {
                        Text("Acompanhamento do time")
                            .font(.system(size: 40, weight: .bold, design: .default))
                            .foregroundColor(Color.black)
                        
                        Spacer()
                    }
                    
                    HStack(spacing: 0) {
                        ZStack {
                            Circle()
                                .foregroundColor(Color.collieRoxo)
                                .frame(width: 48, height: 48)
                            Image(systemName: "person.crop.circle.badge.plus")
                                .font(.system(size: 24, weight: .bold, design: .default))
                                .foregroundColor(.white)
                        }
                        .padding(.trailing)
                        
                        Text("Adicionar colaboradores")
                            .foregroundColor(.black)
                            .bold()
                        
                        Spacer()
                    }
                    .padding()
                    .frame(height: 60)
                    .background(Color.white)
                    .cornerRadius(8)
                    .padding(.bottom)
                    .onTapGesture {
                        print("Add new user on the team")
                    }
                    
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
                            
                            Text("\(user.name)")
                                .foregroundColor(.black)
                            Spacer()
                            
                        }
                        .padding()
                        .frame(height: 60)
                        .background(Color.white)
                        .cornerRadius(8)
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
    }
}

struct TeamListView_Previews: PreviewProvider {
    static var previews: some View {
        TeamListView()
    }
}
