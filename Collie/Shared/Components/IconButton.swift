import SwiftUI

struct IconButton: View {
    var imageSystemName: String
    var action: () -> ()
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: imageSystemName)
                .collieFont(textStyle: .subtitle)
                .foregroundColor(.black)
                .frame(width: 40, height: 40)
                .background(Color.white)
                .cornerRadius(8)
        }
        .buttonStyle(.plain)
        .modifier(CustomBorder())
    }
}

struct IconButton_Previews: PreviewProvider {
    static var previews: some View {
        IconButton(imageSystemName: "lock", action: {})
    }
}
