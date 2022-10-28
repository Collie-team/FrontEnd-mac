import SwiftUI

struct BusinessManagerCalendarCell: View {
    @ObservedObject var bmSingleJourneyListViewModel: BusinessManagerSingleJourneyViewModel
    @ObservedObject var bmEventsCalendarViewModel: BusinessManagerEventsCalendarViewModel
    let count: Int
    let startingSpaces: Int
    let daysInMonth: Int
    let daysInPrevMont: Int
    let day: Int
    let month: Int
    let year: Int
    
    var monthStruct: MonthStruct {
        bmEventsCalendarViewModel.monthStruct(
            startingSpaces: startingSpaces,
            count: count,
            daysInMonth: daysInMonth,
            daysInPrevMonth: daysInPrevMont
        )
    }
    
    var date: Date {
        monthStruct.getDayDate(day: day, month: month, year: year)
    }
    
    var eventsInDate: [Event] = []
//    {
//        bmSingleJourneyListViewModel.journey.events.filter { event in
//            event.startDate == date
//        }
//    }
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .foregroundColor(backgroundColor())
                    .frame(width: 24, height: 24)
                Text(monthStruct.day())
                    .foregroundColor(textColor())
                    .fontWeight(fontWeight())
            }
            HStack {
                ForEach(eventsInDate) { event in
                    Circle()
                        .foregroundColor(event.category?.color ?? .gray)
                        .frame(width: 12, height: 12)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onTapGesture {
            bmEventsCalendarViewModel.selectDate(date: date)
        }
        .onAppear {
            print("Events in date \(date): \(eventsInDate)")
        }
    }
    
    func textColor() -> Color {
        let date = monthStruct.getDayDate(day: day, month: month, year: year)
        if bmEventsCalendarViewModel.isDateSelected(date) {
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
        return bmEventsCalendarViewModel.isDateSelected(date) ? .bold : .regular
    }
    
    func backgroundColor() -> Color {
        let date = monthStruct.getDayDate(day: day, month: month, year: year)
        return bmEventsCalendarViewModel
            .isDateSelected(date) ? Color.collieRoxo : Color.collieCinzaClaro
    }
}
