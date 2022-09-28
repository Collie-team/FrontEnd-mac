import Foundation
import SwiftUI

extension Color {
    static let collieVermelho = Color(red: 255/255, green: 96/255, blue: 86/255)
    static let collieVerde = Color(red: 179/255, green: 227/255, blue: 75/255)
    static let collieAzulClaro = Color(red: 100/255, green: 208/255, blue: 242/255)
    static let collieLaranja = Color(red: 255/255, green: 183/255, blue: 74/255)
    static let collieAzulMedio = Color(red: 74/255, green: 157/255, blue: 255/255)
    static let collieCinzaClaro = Color(red: 227/255, green: 229/255, blue: 253/255)
    static let collieBranco = Color(red: 236/255, green: 240/255, blue: 253/255)
    static let collieAzulEscuro = Color(red: 11/255, green: 0/255, blue: 58/255)
    static let collieRoxo = Color(red: 88/255, green: 63/255, blue: 255/255)
    static let collieAmareloForte = Color(red: 255/255, green: 239/255, blue: 100/255)
    static let collieAmareloFraco = Color(red: 255/255, green: 249/255, blue: 193/255)
    static let collieRosaEscuro = Color(red: 255/255, green: 74/255, blue: 139/255)
    static let collieRosaClaro = Color(red: 255/255, green: 199/255, blue: 225/255)
}

struct Colors {
    func getRandomColor() -> Color {
        let colors: [Color] = [.collieVerde, .collieVermelho, .collieAzulClaro, .collieAzulMedio, .collieLaranja, .collieRosaEscuro, .collieRoxo]
        return colors.randomElement()!
    }
}
