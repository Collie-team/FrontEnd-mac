import SwiftUI

struct HelpView: View {
    var title: String
    var subtitle: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .collieFont(textStyle: .smallTitle)
            Text(subtitle)
                .collieFont(textStyle: .regularText)
        }
        .foregroundColor(.black)
        .padding()
        .background(Color.collieBranco.scaleEffect(1.5))
        .frame(width: 400)
        .fixedSize(horizontal: true, vertical: false)
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView(title: "", subtitle: "")
    }
}
