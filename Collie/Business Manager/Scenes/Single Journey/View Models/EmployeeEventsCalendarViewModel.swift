import Foundation
import Combine
import SwiftUI

final class EmployeeEventsCalendarViewModel: ObservableObject {
    @Binding var date: Date
    @Published var events: [Event]
    
    init(date: Binding<Date>, events: [Event]) {
        self._date = date
        self.events = events
    }
    
    func monthStruct(startingSpaces: Int, count: Int, daysInMonth: Int, daysInPrevMonth: Int) -> MonthStruct {
        let start = startingSpaces == 0 ? startingSpaces + 7 : startingSpaces
        if (count <= start) {
            let day = daysInPrevMonth + count - start
            return MonthStruct(monthType: .previous, dayInt: day)
        } else if ((count - start) > daysInMonth) {
            let day = count - start - daysInMonth
            return MonthStruct(monthType: .next, dayInt: day)
        } else {
            let day = count - start
            return MonthStruct(monthType: .current, dayInt: day)
        }
    }
    
    func isDateSelected(_ date: Date) -> Bool {
        CalendarHelper().areDatesInSameDay(date, self.date)
    }
    
    func selectDate(date: Date) {
        self.date = date
        print("Date selected: \(self.date)")
    }
}
