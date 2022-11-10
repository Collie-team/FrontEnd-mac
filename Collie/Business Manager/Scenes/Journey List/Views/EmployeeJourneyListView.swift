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
        .background(Color.collieBrancoFundo.ignoresSafeArea())
    }
    
    var journeyList: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: true) {
                VStack {
                    HStack {
                        Text("Suas jornadas")
                            .font(.system(size: 40, weight: .bold, design: .default))
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
        .padding(.horizontal)
        .padding(.vertical, 32)
    }
    
    var singleJourney: some View {
        EmployeeSingleJourneyView(
            viewModel: EmployeeSingleJourneyViewModel(journey: viewModel.selectedJourney!),
            employeeJourneyListViewModel: viewModel,
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
