import SwiftUI
import SDWebImageSwiftUI
struct JourneyCard: View {
    @EnvironmentObject var rootViewModel: RootViewModel
    @State var cardSelection: Bool = false
    var journey: Journey
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if let url = URL(string: journey.imageURL), journey.imageURL != "" {
                AnimatedImage(url: url)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .onHover { hover in
                        cardSelection = hover
                    }
                    .overlay(
                        ZStack(alignment: .topTrailing) {
                            HStack(spacing: 8) {
                                Text("Selecionar imagem")
                                Image(systemName: "photo")
                            }
                            .padding()
                            .font(.system(size: 18))
                            .foregroundColor(.white)
                            Rectangle()
                                .fill(.black.opacity(0.2))
                        }
                            .opacity(cardSelection ? 1 : 0)
                    )
            } else {
                Rectangle()
                    .foregroundColor(.collieRosaClaro)
                    .onHover { hover in
                        cardSelection = hover
                    }
                    .overlay(
                        ZStack(alignment: .topTrailing) {
                            HStack(spacing: 8) {
                                Text("Selecionar imagem")
                                Image(systemName: "photo")
                            }
                            .padding()
                            .font(.system(size: 18))
                            .foregroundColor(.white)
                            Rectangle()
                                .fill(.black.opacity(0.2))
                        }
                            .opacity(cardSelection ? 1 : 0)
                    )
            }
                
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text(journey.name)
                        .collieFont(textStyle: .title)
                        .lineLimit(1)
                    Spacer()
                }
            }
            .padding()
            .foregroundColor(.black)
            .background(Color.white)
        }
        .frame(height: 320)
        .frame(maxWidth: .infinity)
        .cornerRadius(16)
    }
}

struct JourneyCard_Previews: PreviewProvider {
    static var previews: some View {
        JourneyCard(journey: Journey(
            name: "Jornada iOS",
            description: "Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo",
            imageURL: "",
            startDate: Date(),
            userIds: []
        ))
    }
}
