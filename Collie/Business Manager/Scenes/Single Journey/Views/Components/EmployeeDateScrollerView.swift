import SwiftUI

struct EmployeeDateScrollerView: View {
    
    @ObservedObject var employeeEventsCalendarViewModel: EmployeeEventsCalendarViewModel
    
    var body: some View {
        HStack {
            Spacer()
            
            IconButton(imageSystemName: "arrow.left") {
                previousMonth()
            }
            
            Text(CalendarHelper().monthYearString(employeeEventsCalendarViewModel.date))
                .collieFont(textStyle: .smallTitle)
                .frame(maxWidth: .infinity)
            
            IconButton(imageSystemName: "arrow.right") {
                nextMonth()
            }
            
            Spacer()
        }
    }
    
    func previousMonth() {
        employeeEventsCalendarViewModel.date = CalendarHelper().minusMonth(employeeEventsCalendarViewModel.date)
    }
    
    func nextMonth() {
        employeeEventsCalendarViewModel.date = CalendarHelper().plusMonth(employeeEventsCalendarViewModel.date)
    }
}

