import SwiftUI

struct EmployeeTaskView: View {
    @EnvironmentObject var rootViewModel: RootViewModel
    
    var task: Task
    var userTask: UserTask
    var checked: Bool
    var isLate: Bool
    var handleTaskOpen: () -> ()
    var handleTaskCheckToggle: () -> ()
    
    let lateBackgroundColor = Color(red: 255/255, green: 237/255, blue: 237/255)
    
    
    var category: TaskCategory {
        rootViewModel.getCategory(categoryId: task.categoryId ?? "")
    }
    
    var body: some View {
        ZStack {
            if isLate {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(checked ? .collieVerde : .collieVermelho)
                    HStack {
                        Text("!")
                            .collieFont(textStyle: .title)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                        Spacer()
                    }
                }
            }
            HStack {
                CheckBoxView(checked: checked, handleCheckToggle: handleTaskCheckToggle)
                
                Text(task.name)
                    .foregroundColor(isLate ? .collieVermelho : .black)
                    .collieFont(textStyle: .subtitle)
                    .padding(.leading, 8)
                
                Spacer()
                
                if isLate {
                    HStack(spacing: 8) {
                        Image(systemName: "clock")
                            .collieFont(textStyle: .regularText)
                        Text("Atrasada!")
                            .collieFont(textStyle: .regularText, textSize: 14)
                    }
                    .foregroundColor(.collieVermelho)
                    .padding(.trailing)
                } else {
                    HStack(spacing: 8) {
                        Image(systemName: "calendar")
                            .collieFont(textStyle: .regularText)
                        Text(CalendarHelper().dateString(task.endDate))
                            .collieFont(textStyle: .regularText, textSize: 14)
                    }
                    .foregroundColor(.black)
                    .padding(.trailing)
                }
                
                Text(category.name)
                    .foregroundColor(.white)
                    .collieFont(textStyle: .subtitle, textSize: 12)
                    .padding(.horizontal)
                    .padding(.vertical, 4)
                    .background(category.color)
                    .cornerRadius(50)
            }
            .padding(.vertical, 8)
            .padding(.horizontal)
            .frame(height: 46)
            .background(isLate ? lateBackgroundColor :Color.white)
            .cornerRadius(8)
            .modifier(CustomBorder())
            .padding(.leading, isLate ? 42 : 0)
        }
        .onTapGesture {
            handleTaskOpen()
        }
        .background(Color.clear)
        .frame(height: 46)
        .frame(maxWidth: .infinity)
        .cornerRadius(8)
    }
}

//struct EmployeeTaskView_Previews: PreviewProvider {
//    static var previews: some View {
//        EmployeeTaskView(
//            task: .init(journeyId: "", name: "Enviar a cópia dos documentos", description: "Decrição Decrição Decrição Decrição Decrição Decrição Decrição Decrição ", startDate: Date(), endDate: Date(), taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star")),
//            userTask: UserTask(taskId: "dsaa", journeyId: "sadsasd", doneDate: nil), checked: false, isLate: true, handleTaskOpen: {}, handleTaskCheckToggle: {})
//    }
//}
