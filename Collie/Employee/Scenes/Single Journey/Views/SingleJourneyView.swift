import SwiftUI

struct SingleJourneyView: View {
    var journey: Journey
    var backAction: () -> ()
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 16) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 30, weight: .bold, design: .default))
                    .onTapGesture {
                        backAction()
                    }
                
                Text(journey.title)
                    .font(.system(size: 40, weight: .bold, design: .default))
                
                Spacer()
            }
            .foregroundColor(.white)
            .padding(.bottom)
            
            Text(journey.subtitle)
                .font(.system(size: 18, weight: .regular, design: .default))
            
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 32)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.background)
    }
}

struct SingleJourneyView_Previews: PreviewProvider {
    static var previews: some View {
        SingleJourneyView(
            journey: Journey(
                title: "Jornada iOS",
                subtitle: "Jornada feita para os novos desenvolvedores iOS do time da Collie.",
                imageName: ""
            ),
            backAction: {}
        )
    }
}
