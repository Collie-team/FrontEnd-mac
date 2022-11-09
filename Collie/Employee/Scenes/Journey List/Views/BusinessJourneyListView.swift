import SwiftUI

struct BusinessJourneyListView: View {
    @EnvironmentObject var rootViewModel: RootViewModel
    @StateObject var viewModel = BusinessJourneyListViewModel()
    
    @State var showCreationPopUp = false
    @State var selectedJourney: Journey? = nil
    
    var gridItems: [GridItem] = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        ZStack {
            switch viewModel.navigationState {
            case .journeyList:
                journeyList
            case .singleJourney:
                singleJourney
            }
            
            if showCreationPopUp {
                ZStack {
                    Color.black.opacity(0.5)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    CreateOrEditJourneyView(
                        journey: viewModel.selectedJourney,
                        handleClose: {
                            withAnimation {
                                showCreationPopUp = false
                            }
                        },
                        handleJourneySave: { journey in
                            viewModel.addNewJourney(journey, business: rootViewModel.businessSelected) { business in
                                viewModel.selectedJourney = journey
                                rootViewModel.updateBusiness(business)
                            }
                        }
                    )
                    .frame(maxWidth: 800)
                }
            }
            
        }
        .navigationTitle("Jornadas")
        .background(Color.collieBrancoFundo.ignoresSafeArea())
        .onAppear {
            rootViewModel.refreshBusiness()
        }
    }
    
    var journeyList: some View {
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
                        
                        ForEach(rootViewModel.businessSelected.journeys) { journey in
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
    }
    
    var singleJourney: some View {
        BusinessSingleJourneyView(
            viewModel: BusinessSingleJourneyViewModel(
                business: rootViewModel.businessSelected,
                journey: viewModel.selectedJourney!
            ),
            backAction: {
                viewModel.selectedJourney = nil
            }
        )
    }
}
