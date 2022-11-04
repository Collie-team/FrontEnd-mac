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
                    .frame(width: 120, height: 120)
                    .foregroundColor(getRandomColor())
                Text(workspaceInitialString)
                    .font(.system(size: 50, weight: .bold))
                    .foregroundColor(.collieBranco)
            }
            .padding(32)
            
            Divider()
            
            VStack {
                Text(business.name)
                    .font(.system(size: 21, weight: .bold))
//                Text("\(business.userIds.count) Membros")
//                    .font(.system(size: 14, weight: .light))
            }
            .foregroundColor(.black)
        }
        .padding()
        .frame(width: 300)
        .background(Color.white)
        .cornerRadius(8)
        .modifier(CustomBorder())
    }
}

struct BusinessCard_Previews: PreviewProvider {
    static var previews: some View {
        BusinessCard(business: .init(name: "Aurea", description: "", journeys: [], tasks: [], events: []))
            .colorScheme(.light)
    }
}
