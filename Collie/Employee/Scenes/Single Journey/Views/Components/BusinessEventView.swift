import SwiftUI

struct BusinessEventView: View {
    var event: Event
    var category: TaskCategory
    var handleEventOpen: () -> ()
    
    var body: some View {
        HStack(spacing: 16) {
            RoundedRectangle(cornerRadius: 50)
                .frame(width: 5)
                .foregroundColor(category.color)
            VStack(spacing: 8) {
                HStack(spacing: 16) {
                    Image(systemName: category.systemImageName)
                        .foregroundColor(category.color)
                    
                    Text(event.name)
                        .foregroundColor(.black)
                        .lineLimit(1)
                    
                    Spacer()
                }
                .collieFont(textStyle: .subtitle)
                
                HStack {
                    HStack {
                        Image(systemName: "calendar")
                        Text(event.startDate.monthAndYearCustomFormat())
                        
                        Image(systemName: "arrow.right")
                        
                        Text(event.endDate.monthAndYearCustomFormat())
                    }
                    .foregroundColor(.gray)
                    
                    Spacer()
                    
                    Text(category.name)
                        .foregroundColor(.white)
                        .collieFont(textStyle: .subtitle, textSize: 12)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 8)
                        .background(category.color)
                        .cornerRadius(50)
                }
            }
        }
        .padding(8)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(8)
        .modifier(CustomBorder())
        .onTapGesture {
            handleEventOpen()
        }
    }
}

struct BusinessManagerEventView_Previews: PreviewProvider {
    static var previews: some View {
        BusinessEventView(event: Event(journeyId: "", name: "Workshop de Figma", description: "ndsjn dasln dsalnadslkn daslknda slndaslnk", contentLink: "https://oi.com", startDate: Date(timeIntervalSince1970: 1667591752), endDate: Date(timeIntervalSince1970: 1667678152), responsibleUserIds: [], categoryId: ""), category: TaskCategory(name: "diversidade", colorName: "rosa", systemImageName: "star"), handleEventOpen: {})
    }
}
