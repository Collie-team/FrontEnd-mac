import SwiftUI

struct EmployeeEventFullView: View {
    @EnvironmentObject var rootViewModel: RootViewModel
    var event: Event
    var handleClose: () -> ()
    
//    var responsibleName: String = ""
//    var responsibleEmail: String = ""

    @State private var hover: Bool = false
    
    var category: TaskCategory {
        rootViewModel.getCategory(categoryId: event.categoryId ?? "")
    }
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 15) {
                HStack {
                    Text("Evento")
                        .collieFont(textStyle: .regularText)
                        .foregroundColor(.black)
                    Spacer()
                }
                HStack {
                    Text(event.name)
                        .collieFont(textStyle: .title)
                        .foregroundColor(.black)
                    Spacer()
                }
                Text(category.name)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(category.color)
                    .cornerRadius(16)
                    .collieFont(textStyle: .subtitle, textSize: 12)
                    .foregroundColor(.white)
            }
            .padding(.bottom, 30)
            
            VStack(spacing: 24) {
                HStack {
                    TitleWithIconView(systemImageName: "link", label: "Link do evento")
                        .frame(width: 200)
                    if let url = URL(string: event.contentLink) {
                        Link(destination: url) {
                            Text(event.contentLink)
                                .collieFont(textStyle: .subtitle)
                                .foregroundColor(hover ? .collieLilas : .collieRoxo)
                        }
                        .onHover { isHovered in
                            self.hover = isHovered
                            DispatchQueue.main.async {
                                if (self.hover) {
                                    NSCursor.pointingHand.push()
                                } else {
                                    NSCursor.pop()
                                }
                            }
                        }
                    } else {
                        Text("Nenhum link disponível")
                            .collieFont(textStyle: .regularText)
                    }
                    Spacer()
                }
                
                HStack {
                    TitleWithIconView(systemImageName: "calendar", label: "Data de início")
                        .frame(width: 200)
                    Text(CalendarHelper().dateString(event.startDate))
                        .collieFont(textStyle: .regularText)
                    Spacer()
                }
                HStack {
                    TitleWithIconView(systemImageName: "calendar", label: "Data de término")
                        .frame(width: 200)
                    Text(CalendarHelper().dateString(event.endDate))
                        .collieFont(textStyle: .regularText)
                    Spacer()
                }
                
                HStack(alignment: .top) {
                    TitleWithIconView(systemImageName: "doc.text.fill", label: "Descrição da tarefa")
                        .frame(width: 200)
                    Text(event.description)
                        .collieFont(textStyle: .regularText)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
            }
            .foregroundColor(.black)
            
        }
        .padding(.leading, 90)
        .padding(.trailing, 60)
        .padding(.vertical, 45)
        .frame(maxWidth: .infinity)
        .background(
            HStack(spacing: 0) {
                Rectangle()
                    .foregroundColor(category.color)
                    .frame(width: 30)
                ZStack {
                    Rectangle()
                        .foregroundColor(Color.collieBranco)
                    VStack {
                        HStack {
                            Spacer()
                            Button {
                                handleClose()
                            } label: {
                                Image(systemName: "xmark")
                                    .collieFont(textStyle: .title)
                                    .foregroundColor(.black)
                            }
                            .buttonStyle(.plain)
                        }
                        Spacer()
                    }
                    .padding(16)
                }
            }
        )
        .cornerRadius(8)
    }
}

struct EmployeeEventFullView_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeEventFullView(
            event: Event(
                journeyId: "", name: "Workshop de Produtividade",
                description: "sdkjads kadsjl aksla dslkads lkad sklds ajlkdas jadlsk  sadlkasdn",
                contentLink: "https://aurea.yoga",
                startDate: Date(),
                endDate: Date(),
                responsibleUserIds: []
            ),
            handleClose: {}
        )
    }
}
