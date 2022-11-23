import SwiftUI

struct TitleWithIconView: View {
    var systemImageName: String
    var label: String
    
    var body: some View {
        HStack {
            Image(systemName: systemImageName)
            Text(label)
            Spacer()
        }
        .collieFont(textStyle: .subtitle)
        .foregroundColor(.black)
    }
}

struct TitleWithIconView_Previews: PreviewProvider {
    static var previews: some View {
        TitleWithIconView(systemImageName: "calendar", label: "Calendário")
    }
}
