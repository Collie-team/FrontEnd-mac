import SwiftUI

struct BusinessDateScrollerView: View {
    
    @ObservedObject var businessManagerEventsCalendarViewModel: BusinessEventsCalendarViewModel
    
    var body: some View {
        HStack {
            Spacer()
            
            IconButton(imageSystemName: "arrow.left") {
                previousMonth()
            }
            
            Text(CalendarHelper().monthYearString(businessManagerEventsCalendarViewModel.date))
                .collieFont(textStyle: .smallTitle)
                .frame(maxWidth: .infinity)
            
            IconButton(imageSystemName: "arrow.right") {
                nextMonth()
            }
            
            Spacer()
        }
    }
    
    func previousMonth() {
        businessManagerEventsCalendarViewModel.date = CalendarHelper().minusMonth(businessManagerEventsCalendarViewModel.date)
    }
    
    func nextMonth() {
        businessManagerEventsCalendarViewModel.date = CalendarHelper().plusMonth(businessManagerEventsCalendarViewModel.date)
    }
}

