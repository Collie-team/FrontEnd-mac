import SwiftUI

struct JourneyCard: View {
    var journey: Journey
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if let nsImage = NSImage(contentsOf: journey.imageURL) {
                Image(nsImage: nsImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 200)
                    
            } else {
                Rectangle()
                    .foregroundColor(.collieRosaClaro)
                    .frame(height: 200)
            }
                
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text(journey.name)
                        .font(.system(size: 24, weight: .bold, design: .default))
                        .lineLimit(1)
                    Spacer()
                }
                HStack(spacing: 0) {
                    Text((journey.managers.count > 1) ? "Gestores: " : "Gestor: ")
                        .bold()
                    
                    ForEach(journey.managers) { manager in
                        if journey.managers.firstIndex(of: manager) == journey.managers.count - 1 {
                            Text("\(manager.name)")
                        } else {
                            Text("\(manager.name), ")
                        }
                    }
                }
                HStack {
                    Text("\(journey.usersIds.count) pessoas nessa jornada")
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
            durationInDays: 7,
            description: "Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo",
            imageURL: URL(fileURLWithPath: ""),
            usersIds: [],
            tasks: [
                Task(name: "Falar com X pessoa", description: "", taskCategory: TaskCategory(name: "Integração", description: "", colorName: "")),
                Task(name: "A", description: "", taskCategory: TaskCategory(name: "Integração", description: "", colorName: "")),
                Task(name: "B", description: "", taskCategory: TaskCategory(name: "Integração", description: "", colorName: "")),
                Task(name: "C", description: "", taskCategory: TaskCategory(name: "Integração", description: "", colorName: "")),
                Task(name: "D", description: "", taskCategory: TaskCategory(name: "Integração", description: "", colorName: "")),
                Task(name: "E", description: "", taskCategory: TaskCategory(name: "Integração", description: "", colorName: "")),
                Task(name: "F", description: "", taskCategory: TaskCategory(name: "Integração", description: "", colorName: "")),
                Task(name: "G", description: "", taskCategory: TaskCategory(name: "Integração", description: "", colorName: "")),
                Task(name: "H", description: "", taskCategory: TaskCategory(name: "Integração", description: "", colorName: "")),
                Task(name: "I", description: "", taskCategory: TaskCategory(name: "Integração", description: "", colorName: "")),
                Task(name: "J", description: "", taskCategory: TaskCategory(name: "Integração", description: "", colorName: ""))
            ],
            managers: []
        ))
    }
}
