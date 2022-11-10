import SwiftUI

struct CreateOrEditCategoryView: View {
    @ObservedObject var viewModel = CreateOrEditCategoryViewModel()
    
    var category: TaskCategory?
    var handleClose: () -> ()
    var handleCategorySave: (TaskCategory) -> ()
    var handleCategoryDelete: (TaskCategory) -> ()
    
    init(
        category: TaskCategory?,
        handleClose: @escaping () -> (),
        handleCategorySave: @escaping (TaskCategory) -> (),
        handleCategoryDelete: @escaping (TaskCategory) -> ()
    ) {
        self.category = category
        self.handleClose = handleClose
        self.handleCategorySave = handleCategorySave
        self.handleCategoryDelete = handleCategoryDelete
        if let category = category {
            viewModel.categoryName = category.name
            viewModel.systemImageName = category.systemImageName
            viewModel.colorName = category.colorName
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                CloseButton(handleClose: handleClose)
            }
            .padding(.top, 8)
            .padding(.trailing, 8)
            
            VStack(spacing: 16) {
                HStack {
                    TitleTextField(text: $viewModel.categoryName, showPlaceholderWhen: viewModel.categoryName.isEmpty, placeholderText: "Nome da categoria")
                    
                    if let category = category {
                        IconButton(imageSystemName: "trash") {
                            handleCategoryDelete(category)
                        }
                    }
                }
                .padding(.bottom, 40)
                

                SendButton(label: "Salvar tarefa", isButtonDisabled: false, handleSend: {
                    // TO DO
                    handleClose()
                })
            }
            .padding(.vertical)
            .padding(.horizontal, 32)
        }
        .background(
            VStack(spacing: 0) {
                viewModel.backgroundColor
                    .frame(height: 130)
                Color.collieBrancoFundo
            }
        )
        .cornerRadius(8)
    }
}

struct CreateOrEditCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CreateOrEditCategoryView(category: TaskCategory(name: "Cultura organizacional", colorName: "roxo", systemImageName: "lock"), handleClose: {}, handleCategorySave: {_ in}, handleCategoryDelete: {_ in})
    }
}
