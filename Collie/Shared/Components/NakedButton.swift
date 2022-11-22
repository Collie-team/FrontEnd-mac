import SwiftUI

struct NakedButton: View {
    var title: String
    var onTap: () -> ()
    
    var body: some View {
        Button {
            onTap()
        } label: {
            Text(title)
                .underline()
                .collieFont(textStyle: .subtitle)
                .foregroundColor(.collieRoxo)
        }
        .buttonStyle(.plain)
    }
}

struct NakedButton_Previews: PreviewProvider {
    static var previews: some View {
        NakedButton(title: "Login", onTap: {})
    }
}
