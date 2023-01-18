import Foundation
import SwiftUI

final class CreateOrEditCategoryViewModel: ObservableObject {
    var categoryId: String?
    @Published var categoryName: String = ""
    @Published var colorName: String = ""
    @Published var systemImageName: String = ""
    
    func getColor(for name: String) -> Color {
        switch name {
        case "rosa":
            return Color.collieRosaEscuro
        case "vermelho":
            return Color.collieVermelho
        case "amarelo":
            return Color.collieAmareloForte
        case "verde":
            return Color.collieVerde
        case "azulClaro":
            return Color.collieAzulClaro
        case "azulEscuro":
            return Color.collieAzulEscuro
        case "roxo":
            return Color.collieRoxo
        default:
            return Color.collieRoxoClaro
        }
    }
    
    var systemNamesArray: [String] = [
        "network",
        "video.fill",
        "envelope.fill",
        "person.crop.rectangle",
        "phone.and.waveform.fill",
        "car.fill",
        "building.2.fill",
        "bubble.left.and.bubble.right.fill"
    ]
    
    var colorNamesArray: [String] = [
        "rosa",
        "vermelho",
        "amarelo",
        "verde",
        "azulClaro",
        "azulEscuro",
        "roxo"
    ]
    
    func isIconSelected(with name: String) -> Bool {
        systemImageName == name
    }
    
    func selectIcon(with name: String) {
        systemImageName = name
    }
    
    func isColorSelected(with name: String) -> Bool {
        colorName == name
    }
    
    func selectColor(with name: String) {
        colorName = name
    }
}
