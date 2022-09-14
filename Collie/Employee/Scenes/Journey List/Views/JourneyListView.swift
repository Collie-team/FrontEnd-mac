import SwiftUI

struct JourneyListView: View {
    @ObservedObject var viewModel = JourneyListViewModel()
    
    var gridItems: [GridItem] = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        VStack {
            HStack {
                Text("Jornadas")
                    .font(.system(size: 40, weight: .bold, design: .default))
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
            }
            
            LazyVGrid(columns: gridItems, spacing: 16) {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                    Image(systemName: "plus")
                        .font(.system(size: 50, weight: .bold, design: .default))
                        .foregroundColor(.white)
                }
                .frame(height: 250)
                .foregroundColor(.collieRoxo)
                .onTapGesture {
                    print("Create new journey")
                }
                
                ForEach(viewModel.sampleJourneys) { journey in
                    JourneyCard(journey: journey)
                        .frame(height: 250)
                }
            }
            
            Spacer()
        }
        .padding(32)
        .navigationTitle("Jornadas")
    }
}

struct JourneyListView_Previews: PreviewProvider {
    static var previews: some View {
        JourneyListView()
    }
}
