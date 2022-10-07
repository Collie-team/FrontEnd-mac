import SwiftUI

struct CalendarCell: View {
    @ObservedObject var eventsCalendarViewModel: EventsCalendarViewModel
    let count: Int
    let startingSpaces: Int
    let daysInMonth: Int
    let daysInPrevMont: Int
    let day: Int
    let month: Int
    let year: Int
    
    var monthStruct: MonthStruct {
        eventsCalendarViewModel.monthStruct(
            startingSpaces: startingSpaces,
            count: count,
            daysInMonth: daysInMonth,
            daysInPrevMonth: daysInPrevMont
        )
    }
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(backgroundColor())
                .frame(width: 30, height: 30)
            Text(monthStruct.day())
                .foregroundColor(textColor())
                .fontWeight(fontWeight())
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onTapGesture {
            eventsCalendarViewModel.selectDate(date: monthStruct.getDayDate(day: day, month: month, year: year))
        }
    }
    
    func textColor() -> Color {
        let date = monthStruct.getDayDate(day: day, month: month, year: year)
        if eventsCalendarViewModel.isDateSelected(date) {
            return Color.white
        } else {
            if monthStruct.monthType == .current {
                return Color.black
            } else {
                return Color.gray
            }
        }
    }
    
    func fontWeight() -> Font.Weight {
        let date = monthStruct.getDayDate(day: day, month: month, year: year)
        return eventsCalendarViewModel.isDateSelected(date) ? .bold : .regular
    }
    
    func backgroundColor() -> Color {
        let date = monthStruct.getDayDate(day: day, month: month, year: year)
        return eventsCalendarViewModel.isDateSelected(date) ? Color.collieRoxo : Color.collieCinzaClaro
    }
}

struct CalendarCell_Previews: PreviewProvider {
    static var previews: some View {
        CalendarCell(eventsCalendarViewModel: EventsCalendarViewModel(events: []), count: 1, startingSpaces: 1, daysInMonth: 1, daysInPrevMont: 1, day: 0, month: 0, year: 0)
    }
}
