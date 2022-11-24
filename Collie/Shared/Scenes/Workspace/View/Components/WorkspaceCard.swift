import SwiftUI

struct WorkspaceCard: View {
    var business: Business
    
    var body: some View {
        VStack {
            WorkspaceImage(business: business)
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

struct WorkspaceCard_Previews: PreviewProvider {
    static var previews: some View {
        WorkspaceCard(business: .init(name: "Aurea", description: "", journeys: [], tasks: [], categories: [], events: []))
            .colorScheme(.light)
    }
}
