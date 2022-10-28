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
            imageURL: URL(fileURLWithPath: ""),
            startDate: Date()
//            employees: [],
//            tasks: [
//                Task(name: "Falar com X pessoa", description: "", startDate: Date(), endDate: Date(), taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star")),
//                Task(name: "A", description: "", startDate: Date(), endDate: Date(), taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star")),
//                Task(name: "B", description: "", startDate: Date(), endDate: Date(), taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star")),
//                Task(name: "C", description: "", startDate: Date(), endDate: Date(), taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star")),
//                Task(name: "D", description: "", startDate: Date(), endDate: Date(), taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star")),
//                Task(name: "E", description: "", startDate: Date(), endDate: Date(), taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star")),
//                Task(name: "F", description: "", startDate: Date(), endDate: Date(), taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star")),
//                Task(name: "G", description: "", startDate: Date(), endDate: Date(), taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star")),
//                Task(name: "H", description: "", startDate: Date(), endDate: Date(), taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star")),
//                Task(name: "I", description: "", startDate: Date(), endDate: Date(), taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star")),
//                Task(name: "J", description: "", startDate: Date(), endDate: Date(), taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star"))
//            ],
//            events: [],
//            managers: []
        ))
    }
}
