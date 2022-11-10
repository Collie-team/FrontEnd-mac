import SwiftUI

struct EmployeeCalendarCell: View {
    @ObservedObject var employeeSingleJourneyViewModel: EmployeeSingleJourneyViewModel
    @ObservedObject var employeeEventsCalendarViewModel: EmployeeEventsCalendarViewModel
    
    let count: Int
    let startingSpaces: Int
    let daysInMonth: Int
    let daysInPrevMont: Int
    let day: Int
    let month: Int
    let year: Int
    
    var hasEventsInDay: Bool {
        employeeEventsCalendarViewModel.events.contains(where: { CalendarHelper().areDatesInSameDay(date, $0.startDate) })
    }
    
    var monthStruct: MonthStruct {
        employeeEventsCalendarViewModel.monthStruct(
            startingSpaces: startingSpaces,
            count: count,
            daysInMonth: daysInMonth,
            daysInPrevMonth: daysInPrevMont
        )
    }
    
    var date: Date {
        monthStruct.getDayDate(day: day, month: month, year: year)
    }
    
    var body: some View {
        VStack(spacing: 4) {
            ZStack {
                Circle()
                    .foregroundColor(backgroundColor())
                    .frame(width: 24, height: 24)
                Text(monthStruct.day())
                    .foregroundColor(textColor())
                    .fontWeight(fontWeight())
            }
            
            Circle()
                .foregroundColor(.collieRoxo)
                .frame(width: 5, height: 5)
                .opacity(hasEventsInDay ? 1 : 0)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .opacity(getCellOpacity())
        .onTapGesture {
            employeeEventsCalendarViewModel.selectDate(date: date)
        }
    }
    
    func getCellOpacity() -> Double {
        if hasEventsInDay || employeeEventsCalendarViewModel.isDateSelected(date) {
            return 1
        } else {
            if monthStruct.monthType == .current {
                return 0.4
            } else {
                return 0.2
            }
        }
    }
    
    func textColor() -> Color {
        employeeEventsCalendarViewModel.isDateSelected(date) ? Color.white : Color.black
    }
    
    func fontWeight() -> Font.Weight {
        employeeEventsCalendarViewModel.isDateSelected(date) ? .bold : .regular
    }
    
    func backgroundColor() -> Color {
        employeeEventsCalendarViewModel
            .isDateSelected(date) ? Color.collieRoxo : Color.collieCinzaClaro
    }
}
