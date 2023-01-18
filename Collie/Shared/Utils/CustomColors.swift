import Foundation
import SwiftUI

extension Color {
    static let collieCinzaBorda = Color(red: 214/255, green: 219/255, blue: 246/255)
    static let collieBrancoFundo = Color(red: 236/255, green: 240/255, blue: 253/255)
    static let collieBrancoFundoSecoes = Color(red: 249/255, green: 250/255, blue: 255/255)
    static let collieCinzaClaro = Color(red: 227/255, green: 229/255, blue: 253/255)
    static let collieVermelho = Color(red: 255/255, green: 96/255, blue: 86/255)
    static let collieVerde = Color(red: 179/255, green: 227/255, blue: 75/255)
    static let collieLaranja = Color(red: 255/255, green: 183/255, blue: 74/255)
    static let collieAzulClaro = Color(red: 100/255, green: 208/255, blue: 242/255)
    static let collieAzulMedio = Color(red: 74/255, green: 157/255, blue: 255/255)
    static let collieTextFieldBackground = Color(red: 245/255, green: 248/255, blue: 255/255)
    static let collieTextFieldBorder = Color(red: 214/255, green: 219/255, blue: 246/255)
    static let collieCinzaEscuro = Color(red: 41/255, green: 41/255, blue: 41/255)
    static let collieBranco = Color(red: 236/255, green: 240/255, blue: 253/255)
    static let collieAzulEscuro = Color(red: 11/255, green: 0/255, blue: 58/255)
    static let collieRoxo = Color(red: 88/255, green: 63/255, blue: 255/255)
    static let collieRoxoClaro = Color(red: 184/255, green: 197/255, blue: 249/255)
    static let collieLilas = Color(red: 179/255, green: 190/255, blue: 255/255)
    static let collieAmareloForte = Color(red: 255/255, green: 239/255, blue: 100/255)
    static let collieAmareloFraco = Color(red: 255/255, green: 249/255, blue: 193/255)
    static let collieRosaEscuro = Color(red: 255/255, green: 74/255, blue: 139/255)
    static let collieRosaClaro = Color(red: 255/255, green: 199/255, blue: 225/255)
}

struct Colors {
    static func getRandomColor() -> Color {
        let colors: [Color] = [.collieVerde, .collieVermelho, .collieAzulClaro, .collieAzulMedio, .collieLaranja, .collieRosaEscuro, .collieRoxo]
        return colors.randomElement()!
    }
    
    static func getRandomSecondaryColor() -> Color {
        let colors: [Color] = [.collieVerde, .collieVermelho, .collieAzulClaro, .collieAzulMedio, .collieLaranja, .collieRosaEscuro]
        return colors.randomElement()!
    }
    
    static func getColorForIndex(index: Int) -> Color {
        let colors: [Color] = [.collieVerde, .collieVermelho, .collieAzulClaro, .collieAzulMedio, .collieLaranja, .collieRosaEscuro]
        let truncatedIndex = index > colors.count - 1 ? index % colors.count : index
        return colors[truncatedIndex]
    }
}
