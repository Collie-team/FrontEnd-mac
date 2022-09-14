import SwiftUI

struct SingleJourneyView: View {
    var journey: Journey
    
    var body: some View {
        VStack {
            
        }
    }
}

struct SingleJourneyView_Previews: PreviewProvider {
    static var previews: some View {
        SingleJourneyView(
            journey: Journey(
                title: "Jornada iOS",
                subtitle: "Jornada feita para os novos desenvolvedores iOS do time da Collie.",
                imageName: ""
            )
        )
    }
}
