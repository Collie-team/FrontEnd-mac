import SwiftUI

struct WorkspaceOptionView: View {
    var systemImageName: String
    var title: String
    var onTap: () -> ()
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(Color.collieCinzaBorda, lineWidth: 3)
                Image(systemName: systemImageName)
                    .font(.system(size: 60, weight: .light))
                    .foregroundColor(Color.collieCinzaBorda)
            }
            .frame(width: 120, height: 120)
            .padding(.vertical, 32)
            
            Divider()
                .frame(height: 2)
                .background(Color.collieCinzaBorda)
                .padding(.horizontal)
            
            Spacer()
            
            Text(title)
                .collieFont(textStyle: .smallTitle)
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
            
            Spacer()
        }
        .frame(width: 250, height: 275)
        .background(Color.white)
        .cornerRadius(8)
        .modifier(CustomBorder())
        .onTapGesture {
            onTap()
        }
    }
}

struct WorkspaceOptionView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                WorkspaceOptionView(systemImageName: "link.badge.plus", title: "Entrar através de um código", onTap: {})
                Spacer()
            }
            Spacer()
        }
        .frame(width: .infinity, height: .infinity)
        .background(Color.collieBrancoFundo)
    }
}
