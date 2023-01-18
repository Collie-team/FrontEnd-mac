import SwiftUI

struct EmployeeTaskFullView: View {
    @ObservedObject var employeeSingleJourneyViewModel: EmployeeSingleJourneyViewModel
    @EnvironmentObject var rootViewModel: RootViewModel
    
    var category: TaskCategory
    var handleClose: () -> ()
    var handleCheckToggle: () -> ()
    
//    var responsibleName: String = ""
//    var responsibleEmail: String = ""
    
    private let green = Color(red: 108/255, green: 217/255, blue: 125/255)
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 15) {
                HStack {
                    Text("Tarefa")
                        .collieFont(textStyle: .regularText)
                        .foregroundColor(.black)
                    Spacer()
                }
                HStack {
                    Text(employeeSingleJourneyViewModel.chosenTaskModel?.task.name ?? "")
                        .collieFont(textStyle: .title)
                        .foregroundColor(.black)
                    Spacer()
                    
                    Button {
                        handleCheckToggle()
                        if employeeSingleJourneyViewModel.chosenTaskModel?.userTask?.doneDate == nil {
                            employeeSingleJourneyViewModel.chosenTaskModel?.userTask?.doneDate = Date().timeIntervalSince1970
                        } else {
                            employeeSingleJourneyViewModel.chosenTaskModel?.userTask?.doneDate = nil
                        }
                    } label: {
                        HStack {
                            Image(systemName: "checkmark")
                                
                            Text(employeeSingleJourneyViewModel.chosenTaskModel?.userTask?.doneDate == nil ? "Marcar como feito" : "Feito")
                        }
                        .foregroundColor(Color.black)
                        .collieFont(textStyle: .subtitle)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(employeeSingleJourneyViewModel.chosenTaskModel?.userTask?.doneDate == nil ? Color.white : green)
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
                    .collieFont(textStyle: .subtitle, textSize: 12)
                    .foregroundColor(.white)
            }
            .padding(.bottom, 30)
            
            VStack(spacing: 24) {
                HStack {
                    TitleWithIconView(systemImageName: "calendar", label: "Data de início")
                        .frame(width: 200)
                    Text(CalendarHelper().dateString((employeeSingleJourneyViewModel.chosenTaskModel?.task.startDate) ?? Date()))
                        .collieFont(textStyle: .regularText)
                    Spacer()
                }
                HStack {
                    TitleWithIconView(systemImageName: "calendar", label: "Data de entrega")
                        .frame(width: 200)
                    Text(CalendarHelper().dateString((employeeSingleJourneyViewModel.chosenTaskModel?.task.endDate) ?? Date()))
                        .collieFont(textStyle: .regularText)
                    Spacer()
                }

                
                HStack(alignment: .top) {
                    TitleWithIconView(systemImageName: "doc.text.fill", label: "Descrição da tarefa")
                        .frame(width: 200)
                    Text(employeeSingleJourneyViewModel.chosenTaskModel?.task.description ?? "")
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
                                employeeSingleJourneyViewModel.unselectTask()
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

//struct EmployeeTaskFullView_Previews: PreviewProvider {
//    static var previews: some View {
//        EmployeeTaskFullView(userTask: UserTask(taskId: "", journeyId: ""), task: Task(journeyId: "", name: "Fazer qualquer coisa", description: "Fazer qualquer coisa faz bem pra saúde", startDate: Date(), endDate: Date()), handleClose: {}, handleCheckToggle: {})
//    }
//}
