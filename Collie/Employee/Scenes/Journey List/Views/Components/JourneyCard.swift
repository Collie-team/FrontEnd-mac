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
                    .frame(height: 200)
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
                    .onTapGesture {
                        rootViewModel.openFileSelectionForJourneyImage(journeyId: journey.id) {_ in}
                    }
            } else {
                Rectangle()
                    .foregroundColor(.collieRosaClaro)
                    .frame(height: 200)
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
                    .onTapGesture {
                        rootViewModel.openFileSelectionForJourneyImage(journeyId: journey.id) {_ in}
                    }
            }
                
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text(journey.name)
                        .font(.system(size: 24, weight: .bold, design: .default))
                        .lineLimit(1)
                    Spacer()
                }
                HStack(spacing: 0) {
//                    Text((journey.managers.count > 1) ? "Gestores: " : "Gestor: ")
//                        .bold()
//
//                    ForEach(journey.managers) { manager in
//                        if journey.managers.firstIndex(of: manager) == journey.managers.count - 1 {
//                            Text("\(manager.name)")
//                        } else {
//                            Text("\(manager.name), ")
//                        }
//                    }
                }
                HStack {
//                    Text("\(journey.employees.count) pessoas nessa jornada")
                }
            }
            .padding()
            .foregroundColor(.black)
            .background(Color.white)
        }
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
