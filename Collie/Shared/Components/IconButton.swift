import SwiftUI

struct IconButton: View {
    var imageSystemName: String
    var action: () -> ()
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: imageSystemName)
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.black)
                .frame(width: 40, height: 40)
                .background(Color.white)
                .cornerRadius(8)
        }
        .buttonStyle(.plain)
    }
}

struct IconButton_Previews: PreviewProvider {
    static var previews: some View {
        IconButton(imageSystemName: "lock", action: {})
    }
}
