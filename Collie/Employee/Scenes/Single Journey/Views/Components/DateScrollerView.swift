import SwiftUI

struct DateScrollerView: View {
    @ObservedObject var eventsCalendarViewModel: EventsCalendarViewModel
    
    var body: some View {
        HStack {
            Spacer()
            
            IconButton(imageSystemName: "arrow.left") {
                previousMonth()
            }
            
            Text(CalendarHelper().monthYearString(eventsCalendarViewModel.date))
                .font(.system(size: 18, weight: .bold))
                .frame(maxWidth: .infinity)
            
            IconButton(imageSystemName: "arrow.right") {
                nextMonth()
            }
            
            Spacer()
        }
    }
    
    func previousMonth() {
        eventsCalendarViewModel.date = CalendarHelper().minusMonth(eventsCalendarViewModel.date)
    }
    
    func nextMonth() {
        eventsCalendarViewModel.date = CalendarHelper().plusMonth(eventsCalendarViewModel.date)
    }
}

struct DateScrollerView_Previews: PreviewProvider {
    static var previews: some View {
        DateScrollerView(eventsCalendarViewModel: EventsCalendarViewModel(events: []))
    }
}
