import SwiftUI

struct BusinessManagerDateScrollerView: View {
    
    @ObservedObject var businessManagerEventsCalendarViewModel: BusinessManagerEventsCalendarViewModel
    
    var body: some View {
        HStack {
            Spacer()
            
            IconButton(imageSystemName: "arrow.left") {
                previousMonth()
            }
            
            Text(CalendarHelper().monthYearString(businessManagerEventsCalendarViewModel.date.wrappedValue))
                .font(.system(size: 18, weight: .bold))
                .frame(maxWidth: .infinity)
            
            IconButton(imageSystemName: "arrow.right") {
                nextMonth()
            }
            
            Spacer()
        }
    }
    
    func previousMonth() {
        businessManagerEventsCalendarViewModel.date.wrappedValue = CalendarHelper().minusMonth(businessManagerEventsCalendarViewModel.date.wrappedValue)
    }
    
    func nextMonth() {
        businessManagerEventsCalendarViewModel.date.wrappedValue = CalendarHelper().plusMonth(businessManagerEventsCalendarViewModel.date.wrappedValue)
    }
}

