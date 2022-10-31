import SwiftUI

struct UserIconView: View {
    var user: UserModel
    
    var body: some View {
        VStack {
            if user.imageURL == "" {
                ZStack {
                    Circle()
                        .foregroundColor(getRandomColor())
                        .frame(width: 30, height: 30)
                    Text(getUserInitials())
                }
            } else {
                // TO DO
            }
        }
    }
    
    func getUserInitials() -> String {
        var initials: String = ""
        let names = user.name.split(separator: " ")
        
        for i in 0...names.count - 1 {
            if i <= 1 {
                initials += names[i].prefix(1)
            }
        }
        
        return initials
    }
    
    func getRandomColor() -> Color {
        let colors: [Color] = [.collieVerde, .collieVermelho, .collieAzulClaro, .collieAzulMedio, .collieLaranja, .collieRosaEscuro, .collieRoxo]
        return colors.randomElement()!
    }
}

struct UserIconView_Previews: PreviewProvider {
    static var previews: some View {
        UserIconView(user: UserModel(name: "André Arns", email: "", jobDescription: "", personalDescription: "", imageURL: "", businessId: []))
    }
}
