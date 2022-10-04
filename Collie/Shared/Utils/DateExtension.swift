import Foundation

extension Date {
    func collieCustomFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM HH:mm"
        return dateFormatter.string(from: self)
    }
}
