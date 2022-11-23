import SwiftUI

struct EmployeeTaskSection: View {
    var sectionTitle: String
    var systemImageName: String
    @Binding var shouldShowTasks: Bool
    
    var body: some View {
        HStack {
            Text("\(Image(systemName: systemImageName))  \(sectionTitle)")
            
            Spacer()
            
            Image(systemName: shouldShowTasks ? "chevron.up" : "chevron.down")
        }
        .collieFont(textStyle: .subtitle)
        .foregroundColor(.black)
        .padding(.horizontal, 12)
        .frame(height: 46)
        .background(Color.collieBrancoFundo)
        .cornerRadius(8)
        .onTapGesture {
            withAnimation {
                shouldShowTasks.toggle()
            }
        }
    }
}

struct EmployeeTaskSection_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeTaskSection(sectionTitle: "Tarefas do dia", systemImageName: "calendar", shouldShowTasks: .constant(true))
    }
}
