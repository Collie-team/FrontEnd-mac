import SwiftUI

struct JourneyListView: View {
    @ObservedObject var viewModel = JourneyListViewModel()
    
    @State var showCreationPopUp = false
    
    var gridItems: [GridItem] = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView(.vertical, showsIndicators: true) {
                    VStack {
                        HStack {
                            Text("Jornadas")
                                .font(.system(size: 40, weight: .bold, design: .default))
                                .foregroundColor(Color.black)
                            Spacer()
                            
                            HStack {
                                Image(systemName: "plus")
                                Text("Criar nova jornada")
                            }
                            .padding(.vertical, 8)
                            .padding(.horizontal)
                            .background(Color.collieRoxo)
                            .cornerRadius(50)
                            .font(.system(size: 16, weight: .bold, design: .default))
                            .foregroundColor(.white)
                            .onTapGesture {
                                showCreationPopUp = true
                            }
                        }
                        
                        LazyVGrid(columns: gridItems, spacing: 16) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 16)
                                Image(systemName: "plus")
                                    .font(.system(size: 50, weight: .bold, design: .default))
                                    .foregroundColor(.white)
                            }
                            .frame(height: 320)
                            .foregroundColor(.collieRoxo)
                            .onTapGesture {
                                showCreationPopUp = true
                            }
                            
                            ForEach(viewModel.sampleJourneys.reversed()) { journey in
                                JourneyCard(journey: journey)
                                    .frame(height: 320)
                                    .onTapGesture {
                                        viewModel.selectedJourney = journey
                                    }
                            }
                        }
                        
                        Spacer()
                    }
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 32)
            
            if viewModel.selectedJourney != nil {
                SingleJourneyView(journey: viewModel.selectedJourney!, backAction: {
                    viewModel.selectedJourney = nil
                })
            }
            
            if showCreationPopUp {
                ZStack {
                    Color.black.opacity(0.5)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    CreateNewJourneyView(handleClose: {
                        withAnimation {
                            showCreationPopUp = false
                        }
                    }, handleJourneyCreation: { journey in
                        viewModel.addNewJourney(journey)
                    })
                    .frame(maxWidth: 800)
                }
            }
            
        }
        .navigationTitle("Jornadas")
        .background(Color.collieBranco.ignoresSafeArea())
    }
    
}

struct JourneyListView_Previews: PreviewProvider {
    static var previews: some View {
        JourneyListView()
    }
}
