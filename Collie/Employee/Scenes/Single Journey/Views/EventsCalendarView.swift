import SwiftUI

struct EventsCalendarView: View {
    @ObservedObject var viewModel: EventsCalendarViewModel
    
    init(events: [Event]) {
        self.viewModel = EventsCalendarViewModel(events: events)
    }
    
    var body: some View {
        VStack {
            VStack {
                DateScrollerView(eventsCalendarViewModel: viewModel)
                dayOfWeekStack
                calendarGrid
            }
            .padding(.vertical)
            .background(Color.white)
            .cornerRadius(8)
            .padding(.bottom)
            
            Divider()
                .padding(.bottom)
            
            HStack {
                Text(viewModel.date.dayAndMonthCustomFormat())
                    .font(.system(size: 18, weight: .bold))
                Spacer()
            }
        }
    }
    
    var dayOfWeekStack: some View {
        HStack(spacing: 1) {
            Text("Dom").dayOfWeek()
            Text("Seg").dayOfWeek()
            Text("Ter").dayOfWeek()
            Text("Qua").dayOfWeek()
            Text("Qui").dayOfWeek()
            Text("Sex").dayOfWeek()
            Text("Sáb").dayOfWeek()
        }
        .font(.system(size: 16, weight: .bold))
    }
    
    var calendarGrid: some View {
        VStack(spacing: 1) {
            let daysInMonth = CalendarHelper().daysInMonth(viewModel.date)
            let firstDayOfMonth = CalendarHelper().firstOfMonth(viewModel.date)
            let startingSpaces = CalendarHelper().weekDay(firstDayOfMonth)
            let prevMonth = CalendarHelper().minusMonth(viewModel.date)
            let daysInPrevMonth = CalendarHelper().daysInMonth(prevMonth)
            let prevMonthLastDayWeekday = CalendarHelper().getLastDayOfMonthWeekday(from: viewModel.date)
            let month = CalendarHelper().month(viewModel.date)
            let year = CalendarHelper().year(viewModel.date)
            
            ForEach(0..<6) { row in
                HStack(spacing: 1) {
                    ForEach(1..<8) { column in
                        let count = column + (row * 7)
                        let day = count - prevMonthLastDayWeekday
                        CalendarCell(eventsCalendarViewModel: viewModel, count: count, startingSpaces: startingSpaces, daysInMonth: daysInMonth, daysInPrevMont: daysInPrevMonth, day: day, month: month, year: year
                        )
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
}

extension Text {
    func dayOfWeek() -> some View {
        self.frame(maxWidth: .infinity)
            .padding(.top, 1)
            .lineLimit(1)
    }
}

struct EventsCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        EventsCalendarView(events: [])
    }
}
