import SwiftUI

struct EventView: View {
    var event: Event
    var handleEventOpen: () -> ()
    
    var body: some View {
        HStack(spacing: 16) {
            RoundedRectangle(cornerRadius: 50)
                .frame(width: 5)
                .foregroundColor(event.category != nil ? event.category!.color : Color.collieRoxoClaro)
            VStack(spacing: 8) {
                HStack(spacing: 16) {
                    if event.category != nil {
                        Image(systemName: event.category!.systemImageName)
                            .foregroundColor(event.category!.color)
                    }
                    
                    Text(event.name)
                        .foregroundColor(.black)
                        .font(.system(size: 16, weight: .semibold))
                        .lineLimit(1)
                    
                    Spacer()
                }
                .font(.system(size: 16))
                
                HStack {
                    HStack {
                        Image(systemName: "calendar")
                        Text(event.startDate.collieCustomFormat())
                        
                        Image(systemName: "arrow.right")
                        
                        Text(event.endDate.collieCustomFormat())
                    }
                    .foregroundColor(.gray)
                    
                    Spacer()
                    
                    if event.category != nil {
                        Text(event.category!.name)
                            .foregroundColor(.white)
                            .font(.system(size: 12, weight: .medium))
                            .padding(.vertical, 4)
                            .padding(.horizontal, 8)
                            .background(event.category!.color)
                            .cornerRadius(50)
                    }
                }
            }
        }
        .padding(8)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(8)
        .onTapGesture {
            handleEventOpen()
        }
    }
}

struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventView(event: Event(name: "Workshop de Figma", description: "ndsjn dasln dsalnadslkn daslknda slndaslnk", link: "https://oi.com", startDate: Date(timeIntervalSince1970: 1667591752), endDate: Date(timeIntervalSince1970: 1667678152), category: TaskCategory(name: "Recursos Humanos", colorName: "vermelho", systemImageName: "person.fill")), handleEventOpen: {})
    }
}
