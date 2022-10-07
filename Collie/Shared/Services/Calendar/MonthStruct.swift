import Foundation

struct MonthStruct {
    var monthType: MonthType
    var dayInt: Int
    
    func day() -> String {
        return String(dayInt)
    }
    
    func getDayDate(day: Int, month: Int, year: Int) -> Date {
        let date = CalendarHelper().getDateFrom(day: day, month: month, year: year)
        return date
    }
}

enum MonthType {
    case previous
    case current
    case next
}
