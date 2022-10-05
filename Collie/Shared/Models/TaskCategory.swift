import SwiftUI

struct TaskCategory: Identifiable, Codable {
    var id: String = UUID().uuidString
    var name: String
    var colorName: String
    var systemImageName: String
    var color: Color {
        switch colorName {
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
}
