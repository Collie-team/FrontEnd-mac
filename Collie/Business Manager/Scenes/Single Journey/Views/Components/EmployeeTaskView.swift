import SwiftUI

struct EmployeeTaskView: View {
    
    var task: Task
    var userTask: UserTask
    var checked: Bool
    
    var handleTaskOpen: () -> ()
    var handleTaskCheckToggle: () -> ()
    
    var body: some View {
        HStack {
            CheckBoxView(checked: checked, handleCheckToggle: handleTaskCheckToggle)
            
            Text(task.name)
                .foregroundColor(.black)
                .font(.system(size: 16, weight: .semibold))
                .padding(.leading, 8)
            
            Spacer()
            
            HStack(spacing: 8) {
                Image(systemName: "calendar")
                    .font(.system(size: 16, weight: .regular))
//                Text(CalendarHelper().dateString(task.endDate))
//                    .font(.system(size: 14, weight: .regular))
            }
            .foregroundColor(.black)
            .padding(.trailing)
            
            if let taskCategory = task.taskCategory {
                Text(taskCategory.name)
                    .foregroundColor(.white)
                    .font(.system(size: 12, weight: .medium))
                    .padding(.horizontal)
                    .padding(.vertical, 4)
                    .background(taskCategory.color)
                    .cornerRadius(50)
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal)
        .frame(height: 46)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(8)
        .modifier(CustomBorder())
        .onTapGesture {
            handleTaskOpen()
        }
    }
}

//struct EmployeeTaskView_Previews: PreviewProvider {
//    static var previews: some View {
//        EmployeeTaskView(task: .init(name: "Enviar a cópia dos documentos", description: "Decrição Decrição Decrição Decrição Decrição Decrição Decrição Decrição ", startDate: Date(), endDate: Date(), taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star")), userTask: UserTask(taskId: "dsaa", journeyId: "sadsasd", doneDate: nil), handleTaskOpen: {}, handleTaskCheckToggle: {})
//    }
//}
