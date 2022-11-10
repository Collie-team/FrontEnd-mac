import SwiftUI

struct EmployeeEventFullView: View {
    var event: Event
    var handleClose: () -> ()
    
    var responsibleName: String = ""
    var responsibleEmail: String = ""
    
    @State private var hover: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 15) {
                HStack {
                    Text("Evento")
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                    Spacer()
                }
                HStack {
                    Text(event.name)
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.black)
                    Spacer()
                }
                Text(event.category?.name ?? "Sem categoria")
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(event.category?.color ?? .gray)
                    .cornerRadius(16)
                    .font(.system(size: 12, weight: .bold))
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
                                .font(.system(size: 16, weight: .medium))
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
                            .font(.system(size: 16))
                    }
                    Spacer()
                }
                
                HStack {
                    TitleWithIconView(systemImageName: "calendar", label: "Data de início")
                        .frame(width: 200)
                    Text(CalendarHelper().dateString(event.startDate))
                        .font(.system(size: 16))
                    Spacer()
                }
                HStack {
                    TitleWithIconView(systemImageName: "calendar", label: "Data de término")
                        .frame(width: 200)
                    Text(CalendarHelper().dateString(event.endDate))
                        .font(.system(size: 16))
                    Spacer()
                }
                
                HStack {
                    TitleWithIconView(systemImageName: "person.fill", label: "Responsável")
                        .frame(width: 200)
                    Text("\(responsibleName) \(responsibleEmail)")
                        .font(.system(size: 16))
                    Spacer()
                }
                
                HStack(alignment: .top) {
                    TitleWithIconView(systemImageName: "doc.text.fill", label: "Descrição da tarefa")
                        .frame(width: 200)
                    Text(event.description)
                        .font(.system(size: 16))
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
                    .foregroundColor(event.category?.color ?? .gray)
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
                                    .font(.system(size: 28, weight: .bold))
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
