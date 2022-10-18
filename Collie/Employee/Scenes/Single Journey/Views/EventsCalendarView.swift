import SwiftUI

struct EventsCalendarView: View {
    @ObservedObject var viewModel: EventsCalendarViewModel
    @ObservedObject var singleJourneyViewModel: SingleJourneyViewModel
    
    var handleSelectEvent: (Event) -> ()
    
    init(selectedDate: Binding<Date>, singleJourneyViewModel: SingleJourneyViewModel, handleSelectEvent: @escaping (Event) -> ()) {
        self.singleJourneyViewModel = singleJourneyViewModel
        self.viewModel = EventsCalendarViewModel(date: selectedDate)
        self.handleSelectEvent = handleSelectEvent
    }
    
    var body: some View {
        VStack {
            VStack {
                DateScrollerView(eventsCalendarViewModel: viewModel)
                dayOfWeekStack
                calendarGrid
            }
            .padding(.bottom)
            
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.collieCinzaBorda)
                .frame(height: 2)
                .frame(maxWidth: .infinity)
                .padding(.bottom)
            
            HStack {
                Text(viewModel.date.wrappedValue.dayAndMonthCustomFormat())
                    .font(.system(size: 18, weight: .bold))
                Spacer()
            }
            
            ScrollView(.vertical) {
                ForEach(singleJourneyViewModel.selectedEvents) { event in
                    EventView(
                        event: event,
                        handleEventOpen: {
                            handleSelectEvent(event)
                        }
                    )
                }
                .padding(2)
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
            let daysInMonth = CalendarHelper().daysInMonth(viewModel.date.wrappedValue)
            let firstDayOfMonth = CalendarHelper().firstOfMonth(viewModel.date.wrappedValue)
            let startingSpaces = CalendarHelper().weekDay(firstDayOfMonth)
            let prevMonth = CalendarHelper().minusMonth(viewModel.date.wrappedValue)
            let daysInPrevMonth = CalendarHelper().daysInMonth(prevMonth)
            let prevMonthLastDayWeekday = CalendarHelper().getLastDayOfMonthWeekday(from: viewModel.date.wrappedValue)
            let month = CalendarHelper().month(viewModel.date.wrappedValue)
            let year = CalendarHelper().year(viewModel.date.wrappedValue)
            
            ForEach(0..<6) { row in
                HStack(spacing: 1) {
                    ForEach(1..<8) { column in
                        let count = column + (row * 7)
                        let day = count - prevMonthLastDayWeekday
                        CalendarCell(
                            singleJourneyListViewModel: singleJourneyViewModel,
                            eventsCalendarViewModel: viewModel,
                            count: count,
                            startingSpaces: startingSpaces,
                            daysInMonth: daysInMonth,
                            daysInPrevMont: daysInPrevMonth,
                            day: day,
                            month: month,
                            year: year
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

//struct EventsCalendarView_Previews: PreviewProvider {
//    static var previews: some View {
//        EventsCalendarView(events: [])
//    }
//}
