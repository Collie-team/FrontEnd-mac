import SwiftUI

struct SingleJourneyView: View {
    var journey: Journey
    var backAction: () -> ()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 16) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 30, weight: .bold, design: .default))
                    .onTapGesture {
                        backAction()
                    }
                
                Text(journey.name)
                    .font(.system(size: 40, weight: .bold, design: .default))
                
                Spacer()
            }
            .foregroundColor(.black)
            .padding(.bottom)
            
            Text(journey.description)
                .font(.system(size: 18, weight: .regular, design: .default))
                .foregroundColor(.black)
            
            
            HStack(spacing: 16) {
                VStack(spacing: 16) {
                    Rectangle()
                        .foregroundColor(.collieBranco.opacity(0))
                        .frame(height: 40)
                        .padding(.vertical)
                    
                    Rectangle()
                        .foregroundColor(Color.collieCinzaClaro)
                    
                    Rectangle()
                        .foregroundColor(Color.collieCinzaClaro)
                }
                .frame(width: 40)
                
                ScrollView(.horizontal, showsIndicators: true) {
                    HStack(spacing: 16) {
                        
                        ForEach(Range(1...self.journey.durationInDays)) { d in
                            VStack(spacing: 16) {
                                ZStack {
                                    Circle()
                                        .foregroundColor(Color.collieRoxo)
                                        .frame(height: 40)
                                    Text("\(d)")
                                        .foregroundColor(.white)
                                        .bold()
                                }
                                .padding(.vertical)
                                .frame(width: 200)
                                .background(Color.collieCinzaClaro)
                                .onTapGesture {
                                    print("Column \(d) touched")
                                }
                                
                                Rectangle()
                                    .foregroundColor(Color.collieCinzaClaro)
                                
                                Rectangle()
                                    .foregroundColor(Color.collieCinzaClaro)
                            }
                        }
                    }
                }
            }
            .padding(.top)
            
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 32)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.collieBranco)
    }
    
    func getColumns(journey: Journey) -> [GridItem] {
        var items: [GridItem] = []
        for _ in 1...journey.durationInDays {
            items.append(GridItem(.flexible()))
        }
        return items
    }
}

struct SingleJourneyView_Previews: PreviewProvider {
    static var previews: some View {
        SingleJourneyView(
            journey: Journey(
                name: "Jornada iOS",
                durationInDays: 7,
                description: "Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo Subtitulo",
                imageURL: "",
                usersIds: [],
                tasks: [
                    Task(name: "Falar com X pessoa", description: "", taskCategory: TaskCategory(name: "Integração", description: "", colorName: "")),
                    Task(name: "A", description: "", taskCategory: TaskCategory(name: "Integração", description: "", colorName: "")),
                    Task(name: "B", description: "", taskCategory: TaskCategory(name: "Integração", description: "", colorName: "")),
                    Task(name: "C", description: "", taskCategory: TaskCategory(name: "Integração", description: "", colorName: "")),
                    Task(name: "D", description: "", taskCategory: TaskCategory(name: "Integração", description: "", colorName: "")),
                    Task(name: "E", description: "", taskCategory: TaskCategory(name: "Integração", description: "", colorName: "")),
                    Task(name: "F", description: "", taskCategory: TaskCategory(name: "Integração", description: "", colorName: "")),
                    Task(name: "G", description: "", taskCategory: TaskCategory(name: "Integração", description: "", colorName: "")),
                    Task(name: "H", description: "", taskCategory: TaskCategory(name: "Integração", description: "", colorName: "")),
                    Task(name: "I", description: "", taskCategory: TaskCategory(name: "Integração", description: "", colorName: "")),
                    Task(name: "J", description: "", taskCategory: TaskCategory(name: "Integração", description: "", colorName: ""))
                ]
            ),
            backAction: {}
        )
    }
}
