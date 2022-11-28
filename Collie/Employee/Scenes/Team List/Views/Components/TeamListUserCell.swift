import SwiftUI
import SDWebImageSwiftUI

struct TeamListUserCell: View {
    var teamListUser: TeamListUser
    
    var body: some View {
        HStack(spacing: 0) {
            if teamListUser.imageURL != "", let url = URL(string: teamListUser.imageURL) {
                AnimatedImage(url: url)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 48, height: 48)
                    .cornerRadius(24)
                    .padding(.trailing)
            } else {
                ZStack {
                    Circle()
                        .frame(width: 48, height: 48)
                        .foregroundColor(.collieRosaClaro)
                    Text("\(getNameLetters(fullName: teamListUser.name))")
                        .collieFont(textStyle: .subtitle)
                }
                .padding(.trailing)
            }
            
            GeometryReader { geometry in
                HStack(alignment: .center, spacing: 0) {
                    Text("\(teamListUser.name)")
                        .collieFont(textStyle: .regularText)
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    VStack {
                        Text(verbatim: teamListUser.email)
                            .collieFont(textStyle: .regularText)
                            .foregroundColor(.black)
                            .opacity(0.5)
                    }
                    .frame(width: geometry.size.width * ListComponents.alignWith(component: .contact))
                    
                    VStack {
                        Text(teamListUser.userJourneys.count > 1 ? teamListUser.userJourneys[0].name + " +\(teamListUser.userJourneys.count - 1)" : teamListUser.userJourneys.count > 0 ? teamListUser.userJourneys[0].name : "Sem jornada")
                            .collieFont(textStyle: .regularText)
                            .foregroundColor(.black)
                    }
                    .frame(width: geometry.size.width * ListComponents.alignWith(component: .journey))
                    
                    VStack {
                        ProgressBarView(doneTasks: teamListUser.doneTasks, totalTasks: teamListUser.totalTasks)
                    }
                    .frame(width: geometry.size.width * ListComponents.alignWith(component: .progress))
                    
                    VStack {
                        Text("\(teamListUser.doneTasks)/\(teamListUser.totalTasks)")
                            .collieFont(textStyle: .regularText)
                            .foregroundColor(.black)
                    }
                    .frame(width: geometry.size.width * ListComponents.alignWith(component: .tasks))
                }
            }
            .foregroundColor(.black)
        }
        .padding()
        .frame(height: 60)
        .background(Color.white)
        .cornerRadius(8)
    }
    
    func getNameLetters(fullName: String) -> String {
        let firstLetter = fullName.components(separatedBy: " ")[0].uppercased().prefix(1)
        let secondLetter = fullName.components(separatedBy: " ").count > 1 ? fullName.components(separatedBy: " ")[1].uppercased().prefix(1) : ""
        return (String(firstLetter + secondLetter))
    }
}
