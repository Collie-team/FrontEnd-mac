import SwiftUI

struct EmployeeDateScrollerView: View {
    
    @ObservedObject var employeeEventsCalendarViewModel: EmployeeEventsCalendarViewModel
    
    var body: some View {
        HStack {
            Spacer()
            
            IconButton(imageSystemName: "arrow.left") {
                previousMonth()
            }
            
            Text(CalendarHelper().monthYearString(employeeEventsCalendarViewModel.date.wrappedValue))
                .font(.system(size: 18, weight: .bold))
                .frame(maxWidth: .infinity)
            
            IconButton(imageSystemName: "arrow.right") {
                nextMonth()
            }
            
            Spacer()
        }
    }
    
    func previousMonth() {
        employeeEventsCalendarViewModel.date.wrappedValue = CalendarHelper().minusMonth(employeeEventsCalendarViewModel.date.wrappedValue)
    }
    
    func nextMonth() {
        employeeEventsCalendarViewModel.date.wrappedValue = CalendarHelper().plusMonth(employeeEventsCalendarViewModel.date.wrappedValue)
    }
}

