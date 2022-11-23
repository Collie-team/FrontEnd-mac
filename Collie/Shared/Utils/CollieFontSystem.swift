import Foundation
import SwiftUI

struct CollieFontSystem: ViewModifier {
    
    @Environment(\.sizeCategory) var sizeCategory
    
    public enum TextStyle {
        case largeTitle
        case title
        case smallTitle
        case subtitle
        case regularText
    }
    
    var textStyle: TextStyle
    var textSize: CGFloat?
    
    func body(content: Content) -> some View {
        return content.font(.system(size: textSize ?? size, weight: weight))
    }
    
    private var size: CGFloat {
        switch textStyle {
        case .largeTitle:
            return 34
        case .title:
            return 28
        case .smallTitle:
            return 20
        case .subtitle, .regularText:
            return 16
        }
    }
    
    private var weight: Font.Weight {
        switch textStyle {
        case .largeTitle, .title, .smallTitle:
            return .bold
        case .subtitle:
            return .semibold
        case .regularText:
            return .regular
        }
    }
}

extension View {
    func collieFont(textStyle: CollieFontSystem.TextStyle, textSize: CGFloat? = nil) -> some View {
        self.modifier(CollieFontSystem(textStyle: textStyle, textSize: textSize))
    }
}

