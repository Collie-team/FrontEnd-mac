import SwiftUI
import SDWebImageSwiftUI
import FirebaseAuth

struct TopUserProfileIcon: View {
    @EnvironmentObject var rootViewModel: RootViewModel
    @State var profileDetailsShowing = false
    
    var navigateToProfileAction: () -> ()
    
    var body: some View {
        HStack {
            Spacer()
            Group {
                if rootViewModel.currentUser.imageURL != "", let url = URL(string: rootViewModel.currentUser.imageURL) {
                    AnimatedImage(url: url)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .cornerRadius(50)
                } else {
                    ZStack {
                        Circle()
                            .foregroundColor(.collieRoxo)
                            .frame(width: 50, height: 50)
                        Text(rootViewModel.currentUser.name.split(separator: " ")[0].description.uppercased().prefix(1) + rootViewModel.currentUser.name.split(separator: " ")[1].description.uppercased().prefix(1))
                            .collieFont(textStyle: .regularText)
                    }
                }
            }
            .onTapGesture {
                profileDetailsShowing.toggle()
            }
            .popover(
                isPresented: $profileDetailsShowing,
                attachmentAnchor: .point(.bottomTrailing),
                arrowEdge: .bottom
            ) {
                ProfilePopUpView(name: rootViewModel.currentUser.name, jobDescription: rootViewModel.currentUser.jobDescription, email: rootViewModel.currentUser.email, imageURL: rootViewModel.currentUser.imageURL, handleLogout: {
                    rootViewModel.exitUserAccount()
                }, navigateToProfileView: {
                    // TODO: Resetar rootView, e outras variaveis
                    navigateToProfileAction()
                })
            }
        }
        .frame(maxWidth: .infinity)
    }
}

struct TopUserProfileIcon_Previews: PreviewProvider {
    static var previews: some View {
        TopUserProfileIcon(navigateToProfileAction: {})
    }
}
