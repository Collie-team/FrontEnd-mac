import SwiftUI

struct BusinessCalendarCell: View {
    @ObservedObject var businessSingleJourneyViewModel: BusinessSingleJourneyViewModel
    @ObservedObject var businessEventsCalendarViewModel: BusinessEventsCalendarViewModel
    
    let count: Int
    let startingSpaces: Int
    let daysInMonth: Int
    let daysInPrevMont: Int
    let day: Int
    let month: Int
    let year: Int
    
    var hasEventsInDay: Bool {
        businessEventsCalendarViewModel.events.contains(where: { CalendarHelper().areDatesInSameDay(date, $0.startDate) })
    }
    
    var monthStruct: MonthStruct {
        businessEventsCalendarViewModel.monthStruct(
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
            businessEventsCalendarViewModel.selectDate(date: date)
        }
    }
    
    func getCellOpacity() -> Double {
        if hasEventsInDay || businessEventsCalendarViewModel.isDateSelected(date) {
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
        businessEventsCalendarViewModel.isDateSelected(date) ? Color.white : Color.black
    }
    
    func fontWeight() -> Font.Weight {
        businessEventsCalendarViewModel.isDateSelected(date) ? .bold : .regular
    }
    
    func backgroundColor() -> Color {
        businessEventsCalendarViewModel
            .isDateSelected(date) ? Color.collieRoxo : Color.collieCinzaClaro
    }
}
