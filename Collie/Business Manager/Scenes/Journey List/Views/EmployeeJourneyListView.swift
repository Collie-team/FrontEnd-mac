import SwiftUI

struct EmployeeJourneyListView: View {
    @EnvironmentObject var rootViewModel: RootViewModel
    @EnvironmentObject var employeeSidebarViewModel: EmployeeSidebarViewModel
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
        .background(Color.collieBrancoFundo.ignoresSafeArea())
    }
    
    var journeyList: some View {
        VStack(spacing: 0) {
            
            ScrollView(.vertical, showsIndicators: true) {
                VStack(spacing: 0) {
                    HStack {
                        Text("Suas jornadas")
                            .collieFont(textStyle: .largeTitle)
                            .foregroundColor(Color.black)
                        
                        Spacer()
                        
                        TopUserProfileIcon {
                            if let profileItem = employeeSidebarViewModel.sidebarItens.first(where: { $0.option == .profile}) {
                                employeeSidebarViewModel.selectedItem = profileItem
                            }
                        }
                    }
                    .padding(.bottom, 32)
                    
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
        .padding(.horizontal, 32)
        .padding(.top, 32)
        .padding(.bottom)
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
