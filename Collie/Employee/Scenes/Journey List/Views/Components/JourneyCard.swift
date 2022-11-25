import SwiftUI
import SDWebImageSwiftUI
struct JourneyCard: View {
    @EnvironmentObject var rootViewModel: RootViewModel
    @State var cardSelection: Bool = false
    let journeyIndex: Int
    var journey: Journey
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if let url = URL(string: journey.imageURL), journey.imageURL != "" {
                AnimatedImage(url: url)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxHeight: 255)
                    .background(.black.opacity(0.05))
                    .onHover { hover in
                        cardSelection = hover
                    }
                    .overlay(
                        HStack {
                            Spacer()
                            VStack {
                                HStack(spacing: 8) {
                                    Text("Selecionar imagem")
                                    Image(systemName: "photo")
                                }
                                .padding(.horizontal)
                                .padding(.vertical, 4)
                                .collieFont(textStyle: .subtitle)
                                .foregroundColor(.white)
                                .background(Color.collieRoxo)
                                .cornerRadius(12)
                                .padding()
                                Spacer()
                            }
                        }
                        .opacity(cardSelection ? 1 : 0)
                        .onTapGesture {
                            rootViewModel.openFileSelectionForJourneyImage(journeyId: journey.id)
                        }
                    )
            } else {
                Rectangle()
                    .foregroundColor(Colors.getColorForIndex(index: journeyIndex))
                    .foregroundColor(.collieRosaClaro)
                    .onHover { hover in
                        cardSelection = hover
                    }
                    .overlay(
                        HStack {
                            Spacer()
                            VStack {
                                HStack(spacing: 8) {
                                    Text("Selecionar imagem")
                                    Image(systemName: "photo")
                                }
                                .padding(.horizontal)
                                .padding(.vertical, 4)
                                .collieFont(textStyle: .subtitle)
                                .foregroundColor(.white)
                                .background(Color.collieRoxo)
                                .cornerRadius(12)
                                .padding()
                                Spacer()
                            }
                        }
                        .opacity(cardSelection ? 1 : 0)
                        .onTapGesture {
                            rootViewModel.openFileSelectionForJourneyImage(journeyId: journey.id)
                        }
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
        JourneyCard(journeyIndex: 1, journey: Journey(
            name: "Jornada iOS",
            description: "Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo",
            imageURL: "",
            startDate: Date(),
            userIds: []
        ))
    }
}
