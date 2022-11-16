import SwiftUI

struct BusinessTaskView: View {
    @EnvironmentObject var rootViewModel: RootViewModel
    var task: Task
    var category: TaskCategory
    var handleTaskOpen: () -> ()
    var handleTaskDuplicate: () -> ()
    @State var showDetailIcon = false
    
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 50)
                .frame(width: 5)
                .foregroundColor(category.color)
            
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
        .modifier(CustomBorder())
        .onTapGesture {
            handleTaskOpen()
        }
        .onHover { over in
            showDetailIcon = over
        }
    }
}

struct BusinessManagerTaskView_Previews: PreviewProvider {
    static var previews: some View {
        BusinessTaskView(
            task: .init(
                journeyId: "",
                name: "Enviar a cópia dos documentos",
                description: "Decrição Decrição Decrição Decrição Decrição Decrição Decrição Decrição ",
                categoryId: "",
                startDate: Date(),
                endDate: Date()),
            category: .init(name: "", colorName: "", systemImageName: ""),
            handleTaskOpen: {},
            handleTaskDuplicate: {})
    }
}
