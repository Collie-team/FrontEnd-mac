import Foundation

final class CalendarHelper {
    let calendar = Calendar.current
    let dateFormatter = DateFormatter()
    
    func monthYearString(_ date: Date) -> String {
        dateFormatter.dateFormat = "MMMM yyyy"
        dateFormatter.locale = Locale(identifier: "pt-BR")
        let string = dateFormatter.string(from: date)
        let firstLetter = String(string.prefix(1).capitalized)
        let other = String(string.dropFirst())
        return firstLetter + other
    }
    
    func dateString(_ date: Date) -> String {
        if calendar.isDateInToday(date) {
            dateFormatter.dateFormat = "HH:mm"
            let hourAndMinuteString = dateFormatter.string(from: date)
            let string = "Hoje às \(hourAndMinuteString)"
            return string
        } else {
            dateFormatter.dateFormat = "dd/MM"
            let dayAndMonthString = dateFormatter.string(from: date)
            dateFormatter.dateFormat = "HH:mm"
            let hourAndMinuteString = dateFormatter.string(from: date)
            let string = dayAndMonthString + " às " + hourAndMinuteString
            return string
        }
    }
    
    func plusMonth(_ date: Date) -> Date {
        calendar.date(byAdding: .month, value: 1, to: date)!
    }
    
    func minusMonth(_ date: Date) -> Date {
        calendar.date(byAdding: .month, value: -1, to: date)!
    }
    
    func daysInMonth(_ date: Date) -> Int {
        let range = calendar.range(of: .day, in: .month, for: date)!
        return range.count
    }
    
    func dayOfMonth(_ date: Date) -> Int {
        let components = calendar.dateComponents([.day], from: date)
        return components.day!
    }
    
    func firstOfMonth(_ date: Date) -> Date {
        let components = calendar.dateComponents([.year, .month], from: date)
        return calendar.date(from: components)!
    }
    
    func weekDay(_ date: Date) -> Int {
        let components = calendar.dateComponents([.weekday], from: date)
        return components.weekday! - 1
    }
    
    func month(_ date: Date) -> Int {
        let components = calendar.dateComponents([.month], from: date)
        return components.month!
    }
    
    func year(_ date: Date) -> Int {
        let components = calendar.dateComponents([.year], from: date)
        return components.year!
    }
    
    func getDateFrom(day: Int, month: Int, year: Int) -> Date {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        return calendar.date(from: dateComponents)!
    }
    
    func areDatesInSameDay(_ date1: Date, _ date2: Date) -> Bool {
        calendar.isDate(date1, inSameDayAs: date2)
    }
    
    func getLastDayOfMonthWeekday(from date: Date) -> Int {
        let lastDayOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: calendar.startOfDay(for: date)))!
        let weekday = calendar.component(.weekday, from: lastDayOfMonth) - 1
        return weekday
    }
}
