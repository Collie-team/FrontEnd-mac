import SwiftUI

struct FilePicker: View {
    var onImageChoose: (String) -> ()
    
    var body: some View {
        Button {
            let openPanel = NSOpenPanel()
            openPanel.prompt = "Escolha uma imagem"
            openPanel.allowsMultipleSelection = false
            openPanel.canChooseDirectories = false
            openPanel.canCreateDirectories = false
            openPanel.canChooseFiles = true
            openPanel.allowedContentTypes = [.jpeg, .png]
            openPanel.begin { (result) -> Void in
                if result.rawValue == NSApplication.ModalResponse.OK.rawValue {
                    let selectedPath = openPanel.url!.path
                    onImageChoose(selectedPath)
                    print(selectedPath)
                }
            }
        } label: {
            Image(systemName: "photo")
                .font(.system(size: 24))
        }
        .buttonStyle(.plain)
        .foregroundColor(.white)
    }
}

struct FilePicker_Previews: PreviewProvider {
    static var previews: some View {
        FilePicker { imagePath in }
    }
}
