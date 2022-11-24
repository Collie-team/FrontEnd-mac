import SwiftUI
import SDWebImageSwiftUI

struct WorkspaceImage: View {
    var business: Business
    
    var workspaceInitialString: String {
        String(business.name.prefix(1))
    }
    
    var body: some View {
        VStack {
            if business.imageURL != "", let url = URL(string: business.imageURL!) {
                AnimatedImage(url: url)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 120)
                    .cornerRadius(120)
            } else {
                ZStack {
                    Circle()
                        .foregroundColor(getRandomColor())
                    Text(business.name.split(separator: " ")[0].description.uppercased().prefix(1))
                        .collieFont(textStyle: .largeTitle, textSize: 50)
                        .foregroundColor(.collieBranco)
                }
                .frame(width: 120, height: 120)
            }
        }
    }
    
    func getRandomColor() -> Color {
        let colors: [Color] = [.collieVerde, .collieVermelho, .collieAzulClaro, .collieAzulMedio, .collieLaranja, .collieRosaEscuro, .collieRoxo]
        return colors.randomElement()!
    }
}

struct WorkspaceImage_Previews: PreviewProvider {
    static var previews: some View {
        WorkspaceImage(business: .init(name: "", description: "", journeys: [], tasks: [], categories: [], events: []))
    }
}
