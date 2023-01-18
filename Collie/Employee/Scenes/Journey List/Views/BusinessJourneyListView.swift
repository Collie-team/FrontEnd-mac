import SwiftUI

struct BusinessJourneyListView: View {
    @EnvironmentObject var rootViewModel: RootViewModel
    @EnvironmentObject var businessSidebarViewModel: BusinessSidebarViewModel
    @StateObject var viewModel = BusinessJourneyListViewModel()
    
    @State var showCreationPopUp = false
    @State var selectedJourney: Journey? = nil
    @State var showJourneyHint = false
    
    var gridItems: [GridItem] = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        ZStack {
            Group {
                switch viewModel.navigationState {
                case .journeyList:
                    journeyList
                case .singleJourney:
                    singleJourney
                }
            }
            
            if showCreationPopUp {
                ZStack {
                    Color.black.opacity(0.5)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    CreateOrEditJourneyView(
                        userId: rootViewModel.currentUser.id,
                        currentBusiness: rootViewModel.businessSelected,
                        journey: viewModel.selectedJourney,
                        handleJourneySave: {_ in},
                        handleClose: {
                            withAnimation {
                                showCreationPopUp = false
                            }
                        }
                    )
                    .frame(maxWidth: 800)
                }
            }
            
        }
        .navigationTitle("Jornadas")
        .background(Color.collieBrancoFundo.ignoresSafeArea())
    }
    
    var journeyList: some View {
        VStack(spacing: 0) {
            ScrollView(.vertical, showsIndicators: true) {
                VStack(spacing: 0) {
                    HStack(alignment: .center, spacing: 8) {
                        Text("Jornadas")
                            .collieFont(textStyle: .largeTitle)
                            .foregroundColor(Color.black)
                        
                        HelpButton {
                            withAnimation {
                                showJourneyHint = true
                            }
                        }
                        .popover(isPresented: $showJourneyHint) {
                            HelpView(
                                title: "Jornada",
                                subtitle: "É o processo de onboarding dos novos colaboradores, organize por grupos que teram as mesmas atividades durante um determinado tempo. Copie e reapreveite elas para novas jornadas."
                            )
                        }
                        
                        Spacer()
                        
                        TopUserProfileIcon {
                            if let profileItem = businessSidebarViewModel.sidebarItens.first(where: { $0.option == .profile}) {
                                businessSidebarViewModel.selectedItem = profileItem
                            }
                        }
                    }
                    .padding(.bottom, 32)
                    
                    LazyVGrid(columns: gridItems, spacing: 16) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                            
                            Image(systemName: "plus")
                                .collieFont(textStyle: .largeTitle, textSize: 60)
                                .foregroundColor(.white)
                        }
                        .frame(height: 320)
                        .foregroundColor(.collieRoxo)
                        .onTapGesture {
                            showCreationPopUp = true
                        }
                        
                        ForEach(rootViewModel.businessSelected.journeys.reversed()) { journey in
                            JourneyCard(journeyIndex: rootViewModel.businessSelected.journeys.reversed().firstIndex(where: {$0.id == journey.id})!, journey: journey)
                            .onTapGesture {
                                viewModel.selectedJourney = journey
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
