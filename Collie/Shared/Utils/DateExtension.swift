import Foundation

extension Date {
    func monthAndYearCustomFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM HH:mm"
        return dateFormatter.string(from: self)
    }
    
    func dayAndMonthCustomFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "pt-BR")
        dateFormatter.dateFormat = "d MMMM"
        let splittedString = dateFormatter.string(from: self).split(separator: " ")
        let monthString = splittedString[1].prefix(1).uppercased() + splittedString[1].dropFirst()
        let string = splittedString[0] + " de " + monthString
        return string
    }
}
