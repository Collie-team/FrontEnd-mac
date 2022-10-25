import SwiftUI

struct BusinessManagerDateScrollerView: View {
    
    @ObservedObject var businessMangerEventsCalendarViewModel: BusinessManagerEventsCalendarViewModel
    
    var body: some View {
        HStack {
            Spacer()
            
            IconButton(imageSystemName: "arrow.left") {
                previousMonth()
            }
            
            Text(CalendarHelper().monthYearString(businessMangerEventsCalendarViewModel.date.wrappedValue))
                .font(.system(size: 18, weight: .bold))
                .frame(maxWidth: .infinity)
            
            IconButton(imageSystemName: "arrow.right") {
                nextMonth()
            }
            
            Spacer()
        }
    }
    
    func previousMonth() {
        businessMangerEventsCalendarViewModel.date.wrappedValue = CalendarHelper().minusMonth(businessMangerEventsCalendarViewModel.date.wrappedValue)
    }
    
    func nextMonth() {
        businessMangerEventsCalendarViewModel.date.wrappedValue = CalendarHelper().plusMonth(businessMangerEventsCalendarViewModel.date.wrappedValue)
    }
}

