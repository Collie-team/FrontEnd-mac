import SwiftUI

struct EmployeeTaskFullView: View {
    @EnvironmentObject var rootViewModel: RootViewModel
    
    var userTask: UserTask
    var task: Task
    var handleClose: () -> ()
    var handleCheckToggle: () -> ()
    
    var responsibleName: String = ""
    var responsibleEmail: String = ""
    
    var category: TaskCategory {
        rootViewModel.getCategory(categoryId: task.categoryId ?? "")
    }
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 15) {
                HStack {
                    Text("Tarefa")
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                    Spacer()
                }
                HStack {
                    Text(task.name)
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.black)
                    Spacer()
                    
                    Button {
                        print("mark check")
                        
                    } label: {
                        HStack {
                            Image(systemName: "checkmark")
                                
                            Text(userTask.doneDate == nil ? "Marcar como feito" : "Feito")
                        }
                        .foregroundColor(userTask.doneDate == nil ? Color.black : Color.white)
                        .font(.system(size: 15, weight: .bold))
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(userTask.doneDate == nil ? Color.white : Color.collieVerde)
                        .cornerRadius(8)
                        .modifier(CustomBorder())
                    }
                    .buttonStyle(.plain)

                }
                Text(category.name)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(category.color)
                    .cornerRadius(16)
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.white)
            }
            .padding(.bottom, 30)
            
            VStack(spacing: 24) {
                HStack {
                    TitleWithIconView(systemImageName: "calendar", label: "Data de início")
                        .frame(width: 200)
                    Text(CalendarHelper().dateString(task.startDate))
                        .font(.system(size: 16))
                    Spacer()
                }
                HStack {
                    TitleWithIconView(systemImageName: "calendar", label: "Data de entrega")
                        .frame(width: 200)
                    Text(CalendarHelper().dateString(task.endDate))
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
                    Text(task.description)
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

//struct EmployeeTaskFullView_Previews: PreviewProvider {
//    static var previews: some View {
//        EmployeeTaskFullView(userTask: UserTask(taskId: "", journeyId: ""), task: Task(journeyId: "", name: "Fazer qualquer coisa", description: "Fazer qualquer coisa faz bem pra saúde", startDate: Date(), endDate: Date()), handleClose: {}, handleCheckToggle: {})
//    }
//}
