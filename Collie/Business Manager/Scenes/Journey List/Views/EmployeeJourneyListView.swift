import SwiftUI

struct EmployeeJourneyListView: View {
    @EnvironmentObject var rootViewModel: RootViewModel
    @StateObject var viewModel = EmployeeJourneyListViewModel()
    
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
        }
        .navigationTitle("Suas jornadas")
        .padding(.horizontal, 32)
        .padding(.top, 32)
        .padding(.bottom)
        .background(Color.collieBrancoFundo.ignoresSafeArea())
    }
    
    var journeyList: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: true) {
                VStack {
                    HStack {
                        Text("Suas jornadas")
                            .collieFont(textStyle: .largeTitle)
                            .foregroundColor(Color.black)
                        Spacer()
                        
                    }
                    
                    LazyVGrid(columns: gridItems, spacing: 16) {
                        
                        ForEach(rootViewModel.businessSelected.journeys.reversed()) { journey in
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
    }
    
    var singleJourney: some View {
        EmployeeSingleJourneyView(
            viewModel: EmployeeSingleJourneyViewModel(
                business: rootViewModel.businessSelected,
                journey: viewModel.selectedJourney!,
                businessUser: rootViewModel.currentBusinessUser!
            ),
            backAction: {
                viewModel.selectedJourney = nil
            }
        )
    }
}

struct EmployeeJourneyListView_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeJourneyListView()
    }
}
