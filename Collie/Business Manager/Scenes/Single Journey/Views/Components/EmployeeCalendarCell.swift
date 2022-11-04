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
    
    var eventsInDate: [Event] = []
//    {
//        employeeSingleJourneyViewModel.journey.events.filter { event in
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
            employeeEventsCalendarViewModel.selectDate(date: date)
        }
        .onAppear {
            print("Events in date \(date): \(eventsInDate)")
        }
    }
    
    func textColor() -> Color {
        let date = monthStruct.getDayDate(day: day, month: month, year: year)
        if employeeEventsCalendarViewModel.isDateSelected(date) {
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
        return employeeEventsCalendarViewModel.isDateSelected(date) ? .bold : .regular
    }
    
    func backgroundColor() -> Color {
        let date = monthStruct.getDayDate(day: day, month: month, year: year)
        return employeeEventsCalendarViewModel
            .isDateSelected(date) ? Color.collieRoxo : Color.collieCinzaClaro
    }
}
