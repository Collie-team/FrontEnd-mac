import SwiftUI

struct UserCellView: View {
    var user: User
    var onTap: () -> ()
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                UserIconView(user: user)
                
                Text(user.name)
                
                Spacer()
                
                Text(user.jobDescription)
            }
            .padding(.vertical, 8)
            
            Divider()
                .frame(height: 1)
        }
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
        UserCellView(user: User(name: "André", email: "andreluisarns@gmail.cm", jobDescription: "", personalDescription: "", imageURL: "", businessId: ""), onTap: {})
    }
}
