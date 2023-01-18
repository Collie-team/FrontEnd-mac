import SwiftUI

struct LoadingBusinessCard: View {
    var business: Business
    
    var workspaceInitialString: String {
        String(business.name.prefix(1))
    }
    
    func getRandomColor() -> Color {
        let colors: [Color] = [.collieVerde, .collieVermelho, .collieAzulClaro, .collieAzulMedio, .collieLaranja, .collieRosaEscuro, .collieRoxo]
        return colors.randomElement()!
    }
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .frame(width: 120, height: 120)
                    .foregroundColor(getRandomColor())
                Text(workspaceInitialString)
                    .collieFont(textStyle: .largeTitle, textSize: 50)
                    .foregroundColor(.collieBranco)
            }
            
            Text(business.name)
                .collieFont(textStyle: .title)
                .foregroundColor(.black)
        }
        .padding()
    }
}

struct LoadingBusinessCard_Previews: PreviewProvider {
    static var previews: some View {
        LoadingBusinessCard(business: .init(name: "Aurea", description: "", journeys: [], tasks: [], categories: [], events: []))
            .colorScheme(.light)
    }
}
