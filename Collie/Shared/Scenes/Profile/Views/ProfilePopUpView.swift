import SwiftUI
import SDWebImageSwiftUI

struct ProfilePopUpView: View {
    var name: String
    var jobDescription: String
    var email: String
    var imageURL: String
    var handleLogout: () -> ()
    var navigateToProfileView: () -> ()
    
    var body: some View {
        VStack(spacing: 14) {
            HStack(alignment:.center) {
                if imageURL != "", let url = URL(string: imageURL) {
                    AnimatedImage(url: url)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 72, height: 72)
                        .cornerRadius(36)
                } else {
                    Circle()
                        .fill(Color.collieRoxo)
                        .frame(width: 72, height: 72)
                        .overlay(
                            Text(name.split(separator: " ")[0].description.uppercased().prefix(1) + name.split(separator: " ")[1].description.uppercased().prefix(1))
                                .foregroundColor(.white)
                                .collieFont(textStyle: .smallTitle)
                        )
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text(name)
                        .collieFont(textStyle: .subtitle)
                        .foregroundColor(.black)
                    Text(jobDescription == "" ? "Sem cargo" : jobDescription)
                        .collieFont(textStyle: .regularText)
                        .foregroundColor(.black.opacity(0.6))
                    Text(email)
                        .collieFont(textStyle: .regularText)
                        .foregroundColor(.black.opacity(0.6))
                    
                }
                Spacer()
            }
            HStack {
                Button(action: {
                    handleLogout()
                }) {
                    Text("Sair \(Image(systemName: "arrow.uturn.right"))")
                        .collieFont(textStyle: .regularText)
                        .foregroundColor(.black.opacity(0.5))
                }
                .buttonStyle(.plain)
                Spacer()
                Button(action: {
                    navigateToProfileView()
                }) {
                    Text("Editar perfil \(Image(systemName: "square.and.pencil"))")
                        .collieFont(textStyle: .regularText)
                        .foregroundColor(Color.collieLilas)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(20)
        .frame(width: 320)
        .background(Color.white)
        .cornerRadius(12)
    }
}

struct ProfilePopUpView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePopUpView(name: "", jobDescription: "", email: "", imageURL: "", handleLogout: {}, navigateToProfileView: {})
    }
}
