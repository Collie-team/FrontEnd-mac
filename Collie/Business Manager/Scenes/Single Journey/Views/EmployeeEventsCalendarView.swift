import SwiftUI

struct EmployeeEventsCalendarView: View {
    @ObservedObject var viewModel: EmployeeEventsCalendarViewModel
    @ObservedObject var employeeSingleJourneyViewModel: EmployeeSingleJourneyViewModel
    
    var handleSelectEvent: (Event) -> ()
    
    init(selectedDate: Binding<Date>, employeeSingleJourneyViewModel: EmployeeSingleJourneyViewModel, handleSelectEvent: @escaping (Event) -> ()) {
        self.employeeSingleJourneyViewModel = employeeSingleJourneyViewModel
        self.viewModel = EmployeeEventsCalendarViewModel(date: selectedDate)
        self.handleSelectEvent = handleSelectEvent
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(viewModel.date.wrappedValue.dayAndMonthCustomFormat())
                    .font(.system(size: 18, weight: .bold))
                Spacer()
            }
            .padding(.top)
            
            VStack {
                ScrollView(.vertical) {
                    if employeeSingleJourneyViewModel.selectedEvents.isEmpty {
                        VStack {
                            Spacer()
                            Image("noEventsImage")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 250)
                                .padding(.bottom)
                            Text("Não tem nenhum evento programado para esse dia!")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(Color.collieLilas)
                                .multilineTextAlignment(.center)
                            Spacer()
                        }
                        .padding()
                    } else {
                        ForEach(employeeSingleJourneyViewModel.selectedEvents) { event in
                            EmployeeEventView(
                                event: event,
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
                EmployeeDateScrollerView(employeeEventsCalendarViewModel: viewModel)
                dayOfWeekStack
                calendarGrid
            }
            .padding(.bottom)
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
                        EmployeeCalendarCell(
                            employeeSingleJourneyViewModel: employeeSingleJourneyViewModel,
                            employeeEventsCalendarViewModel: viewModel,
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

