import SwiftUI

struct SignOutSidebarItem: View {
    var onTap: () -> ()
    
    var body: some View {
        HStack {
            Rectangle()
                .frame(width: 5)
                .opacity(0)
            
            Image(systemName: "arrow.left.to.line.compact")
            
            Text("Sair do workspace")
            
            Spacer()
        }
        .foregroundColor(.white)
        .padding(.trailing)
        .frame(height: 50)
        .padding(.bottom)
        .collieFont(textStyle: .subtitle, textSize: 18)
        .onTapGesture {
            onTap()
        }
    }
}

struct SignOutSidebarItem_Previews: PreviewProvider {
    static var previews: some View {
        SignOutSidebarItem(onTap: {})
    }
}
