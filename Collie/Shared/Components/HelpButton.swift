import SwiftUI

struct HelpButton: View {
    var handleTap: () -> ()
    
    var body: some View {
        Button {
            handleTap()
        } label: {
            Image(systemName: "questionmark.circle")
                .font(.system(size: 21, weight: .bold))
                .foregroundColor(Color.collieLilas)
        }
        .buttonStyle(.plain)
    }
}

struct HelpButton_Previews: PreviewProvider {
    static var previews: some View {
        HelpButton(handleTap: {})
    }
}
