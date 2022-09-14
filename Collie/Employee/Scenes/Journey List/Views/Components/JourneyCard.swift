import SwiftUI

struct JourneyCard: View {
    var journey: Journey
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Rectangle()
                .foregroundColor(.collieRosaClaro)
                
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text(journey.title)
                        .font(.system(size: 24, weight: .bold, design: .default))
                    Spacer()
                }
                HStack(spacing: 0) {
                    Text("Gestor: ")
                        .bold()
                    Text("Nome do gestor")
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
            title: "Jornada iOS",
            subtitle: "Jornada para os novos colaboradores do time iOS da Collie",
            imageName: ""
        ))
    }
}
