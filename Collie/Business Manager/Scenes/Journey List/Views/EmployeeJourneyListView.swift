import SwiftUI

struct EmployeeJourneyListView: View {
    @ObservedObject var viewModel = EmployeeJourneyListViewModel()
    
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
                            Text("Suas jornadas")
                                .font(.system(size: 40, weight: .bold, design: .default))
                                .foregroundColor(Color.black)
                            Spacer()
                            
                        }
                        
                        LazyVGrid(columns: gridItems, spacing: 16) {
                            
                            ForEach(viewModel.sampleJourneys.reversed()) { journey in
                                Text(journey.name)
//                                JourneyCard(journey: $journey)
//                                    .frame(height: 320)
//                                    .onTapGesture {
//                                        viewModel.selectedJourney = journey
//                                    }
                            }
                        }
                        
                        Spacer()
                    }
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 32)
            
            if viewModel.selectedJourney != nil {
                EmployeeSingleJourneyView(
                    viewModel: EmployeeSingleJourneyViewModel(journey: viewModel.selectedJourney!),
                    employeeJourneyListViewModel: viewModel,
                    backAction: {
                        viewModel.selectedJourney = nil
                    }
                )
            }
        }
        .navigationTitle("Suas jornadas")
        .background(Color.collieBrancoFundo.ignoresSafeArea())
    }
}

struct EmployeeJourneyListView_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeJourneyListView()
    }
}
