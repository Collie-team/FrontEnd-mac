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
            if rootViewModel.businessSelected.journeys.filter({$0.userIds.contains(rootViewModel.currentUser.id)}).count == 0 {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Text("Você ainda não possui uma jornada. Aguarde até o responsável do seu time terminar ela para você.")
                            .collieFont(textStyle: .subtitle, textSize: 20)
                        
                        Spacer()
                    }
                    Spacer()
                }
                .background(Color.collieBrancoFundoSecoes)
                .cornerRadius(8)
            } else {
                ScrollView(.vertical, showsIndicators: true) {
                    VStack(spacing: 0) {
                        LazyVGrid(columns: gridItems, spacing: 16) {
                            
                            ForEach(rootViewModel.businessSelected.journeys.filter({$0.userIds.contains(rootViewModel.currentUser.id)}).reversed()) { journey in
                                JourneyCard(journeyIndex: rootViewModel.businessSelected.journeys.reversed().firstIndex(where: {$0.id == journey.id})!, journey: journey)
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
