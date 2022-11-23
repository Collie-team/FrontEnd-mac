import SwiftUI

struct BusinessEventsCalendarView: View {
    @ObservedObject var rootViewModel: RootViewModel
    @ObservedObject var viewModel: BusinessEventsCalendarViewModel
    @ObservedObject var businessSingleJourneyViewModel: BusinessSingleJourneyViewModel
    
    var handleSelectEvent: (Event) -> ()
    
    init(selectedDate: Binding<Date>, events: [Event], rootViewModel: RootViewModel, businessSingleJourneyViewModel: BusinessSingleJourneyViewModel, handleSelectEvent: @escaping (Event) -> ()) {
        self.rootViewModel = rootViewModel
        self.businessSingleJourneyViewModel = businessSingleJourneyViewModel
        self.viewModel = BusinessEventsCalendarViewModel(date: selectedDate, events: events)
        self.handleSelectEvent = handleSelectEvent
    }
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text(viewModel.date.dayAndMonthCustomFormat())
                        .collieFont(textStyle: .smallTitle)
                    Spacer()
                }
                .padding(.top)
                
                VStack {
                    ScrollView(.vertical) {
                        if viewModel.events.filter({ CalendarHelper().areDatesInSameDay($0.startDate, viewModel.date)}).isEmpty {
                            VStack {
                                Spacer()
                                Image("noEventsImage")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: 250)
                                    .padding(.bottom)
                                Text("Não tem nenhum evento programado para esse dia!")
                                    .collieFont(textStyle: .smallTitle)
                                    .foregroundColor(Color.collieLilas)
                                    .multilineTextAlignment(.center)
                                Spacer()
                            }
                            .padding()
                        } else {
                            ForEach(viewModel.events.filter({ CalendarHelper().areDatesInSameDay($0.startDate, viewModel.date)})) { event in
                                BusinessEventView(
                                    event: event,
                                    category: rootViewModel.getCategory(categoryId: event.categoryId ?? ""),
                                    handleEventOpen: {
                                        handleSelectEvent(event)
                                    }
                                )
                            }
                            .padding(2)
                        }
                    }
                    .padding(.bottom)
                    Spacer()
                }
                
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.collieCinzaBorda)
                    .frame(height: 2)
                    .frame(maxWidth: .infinity)
                    .padding(.bottom)
                
                VStack {
                    BusinessDateScrollerView(businessManagerEventsCalendarViewModel: viewModel)
                    
                    dayOfWeekStack
                    
                    calendarGrid
                }
                .padding(.bottom)
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
        .collieFont(textStyle: .subtitle)
    }
    
    var calendarGrid: some View {
        VStack(spacing: 8) {
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
                        BusinessCalendarCell(
                            businessSingleJourneyViewModel: businessSingleJourneyViewModel,
                            businessEventsCalendarViewModel: viewModel,
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
