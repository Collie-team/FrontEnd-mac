import SwiftUI

struct DateScrollerView: View {
    @ObservedObject var eventsCalendarViewModel: EventsCalendarViewModel
    
    var body: some View {
        HStack {
            Spacer()
            
            IconButton(imageSystemName: "arrow.left") {
                previousMonth()
            }
            
            Text(CalendarHelper().monthYearString(eventsCalendarViewModel.date.wrappedValue))
                .font(.system(size: 18, weight: .bold))
                .frame(maxWidth: .infinity)
            
            IconButton(imageSystemName: "arrow.right") {
                nextMonth()
            }
            
            Spacer()
        }
    }
    
    func previousMonth() {
        eventsCalendarViewModel.date.wrappedValue = CalendarHelper().minusMonth(eventsCalendarViewModel.date.wrappedValue)
    }
    
    func nextMonth() {
        eventsCalendarViewModel.date.wrappedValue = CalendarHelper().plusMonth(eventsCalendarViewModel.date.wrappedValue)
    }
}

