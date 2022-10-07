import SwiftUI

struct TaskView: View {
    var task: Task
    var handleTaskOpen: () -> ()
    var handleTaskDuplicate: () -> ()
    @State var showDetailIcon = false
    
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 50)
                .frame(width: 5)
                .foregroundColor(task.taskCategory != nil ? task.taskCategory?.color : Color.collieRoxoClaro)
            
            Text(task.name)
                .foregroundColor(.black)
                .font(.system(size: 16, weight: .semibold))
                .padding(.leading, 8)
            
            Spacer()
            
            if showDetailIcon {
                IconButton(imageSystemName: "rectangle.on.rectangle") {
                    handleTaskDuplicate()
                }
            }
        }
        .padding(8)
        .frame(height: 46)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(8)
        .onTapGesture {
            handleTaskOpen()
        }
        .onHover { over in
            showDetailIcon = over
        }
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(task: .init(name: "Enviar a cópia dos documentos", description: "Decrição Decrição Decrição Decrição Decrição Decrição Decrição Decrição ", startDate: Date(), endDate: Date(), taskCategory: TaskCategory(name: "Integração", colorName: "", systemImageName: "star")), handleTaskOpen: {}, handleTaskDuplicate: {})
    }
}
