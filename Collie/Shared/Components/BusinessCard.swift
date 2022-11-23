import SwiftUI

struct BusinessCard: View {
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
                    .foregroundColor(getRandomColor())
                Text(workspaceInitialString)
                    .collieFont(textStyle: .largeTitle, textSize: 50)
                    .foregroundColor(.collieBranco)
            }
            .frame(width: 120, height: 120)
            .padding(.vertical, 32)
            
            Divider()
                .frame(height: 2)
                .background(Color.collieCinzaBorda)
                .padding(.horizontal)
            
            Spacer()
            
            Text(business.name)
                .collieFont(textStyle: .smallTitle)
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
            
            Spacer()
        }
        .frame(width: 250, height: 275)
        .background(Color.white)
        .cornerRadius(8)
        .modifier(CustomBorder())
    }
}

struct BusinessCard_Previews: PreviewProvider {
    static var previews: some View {
        BusinessCard(business: .init(name: "Aurea", description: "", journeys: [], tasks: [], categories: [], events: []))
            .colorScheme(.light)
    }
}
