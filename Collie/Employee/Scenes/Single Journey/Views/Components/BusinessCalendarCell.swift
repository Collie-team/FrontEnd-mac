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
                .frame(width: 12, height: 12)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onTapGesture {
            businessEventsCalendarViewModel.selectDate(date: date)
        }
    }
    
    func textColor() -> Color {
        let date = monthStruct.getDayDate(day: day, month: month, year: year)
        if businessEventsCalendarViewModel.isDateSelected(date) {
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
        return businessEventsCalendarViewModel.isDateSelected(date) ? .bold : .regular
    }
    
    func backgroundColor() -> Color {
        let date = monthStruct.getDayDate(day: day, month: month, year: year)
        return businessEventsCalendarViewModel
            .isDateSelected(date) ? Color.collieRoxo : Color.collieCinzaClaro
    }
}