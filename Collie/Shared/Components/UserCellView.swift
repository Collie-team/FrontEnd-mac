import SwiftUI

struct UserCellView: View {
    var user: UserModel
    var onTap: () -> ()
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                UserIconView(user: user)
                    .frame(width: 30, height: 30)
                
                Text(user.name)
                
                Spacer()
                
                Text(user.jobDescription)
            }
            .padding(.vertical, 8)
            
            Divider()
                .frame(height: 1)
        }
        .collieFont(textStyle: .regularText)
        .padding(.horizontal)
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation {
                onTap()
            }
        }
    }
}

struct UserCellView_Previews: PreviewProvider {
    static var previews: some View {
        UserCellView(user: UserModel(name: "André", email: "andreluisarns@gmail.cm", jobDescription: "", personalDescription: "", imageURL: ""), onTap: {})
    }
}
