import SwiftUI

struct CategorySelectionDropdown: View {
    @Binding var showList: Bool
    @Binding var chosenCategory: TaskCategory?
    var taskCategoriesList: [TaskCategory]
    var maxScrollHeight: CGFloat
    var handleCategorySelection: (TaskCategory) -> ()
    
    var body: some View {
        VStack {
            VStack {
                ScrollView(.vertical) {
                    VStack(spacing: 0) {
                        Group {
                            if chosenCategory == nil {
                                HStack {
                                    Text("Escolher categoria")
                                    Spacer()
                                    Image(systemName: "chevron.down")
                                }
                                .contentShape(Rectangle())
                            } else {
                                HStack {
                                    CategoryCell(taskCategory: chosenCategory!, onSelect: {})
                                    Spacer()
                                    Image(systemName: "chevron.down")
                                }
                                .contentShape(Rectangle())
                            }
                        }
                        .contentShape(Rectangle())
                        .font(.system(size: 16))
                        .frame(height: 40)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal)
                        .onTapGesture {
                            withAnimation {
                                showList.toggle()
                            }
                        }
                        
                        Divider()
                            .frame(height: 1)
                            .padding(.horizontal)

                        if showList {
                            ForEach(taskCategoriesList) { taskCategory in
                                VStack(spacing: 0) {
                                    CategoryCell(taskCategory: taskCategory) {
                                        handleCategorySelection(taskCategory)
                                        showList = false
                                    }
                                    Divider()
                                        .frame(height: 1)
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                    .cornerRadius(8)
                }
                .frame(maxHeight: maxScrollHeight)
            }
            .background(Color.white)
            .foregroundColor(.black)
            .cornerRadius(8)
        }
    }
}

struct CategoryCell: View {
    var taskCategory: TaskCategory
    var onSelect: () -> ()
    
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .foregroundColor(taskCategory.color)
                Image(systemName: taskCategory.systemImageName)
                    .foregroundColor(.white)
                    .font(.system(size: 14))
            }
            .frame(width: 30, height: 30)
            
            Text(taskCategory.name)
                .foregroundColor(.black)
                .font(.system(size: 15))
            Spacer()
        }
        .padding(.vertical, 8)
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation {
                onSelect()
            }
        }
    }
}

//struct CategorySelectionDropdown_Previews: PreviewProvider {
//    static var previews: some View {
//        CategorySelectionDropdown(
//            taskCategoriesList: [
//                TaskCategory(name: "Cultura organizacional", colorName: "vermelho", systemImageName: "lock"),
//                TaskCategory(name: "Festa", colorName: "roxo", systemImageName: "start"),
//                TaskCategory(name: "Processos", colorName: "azulClaro", systemImageName: "star")
//            ],
//            handleCategorySelection: { _ in
//                
//            }
//        )
//    }
//}
