import SwiftUI

struct CalendarView: View {
    @ObservedObject var viewModel: CalendarViewModel
    
    init(viewModel: CalendarViewModel) {
        self.viewModel = CalendarViewModel()
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    HeaderView()
                    ScrollView {
                        LazyVGrid(columns: Array(repeating: GridItem(), count: 7)) {
                            ForEach(viewModel.getCalendarData(), id: \.self) { week in
                                ForEach(week, id: \.date) { day in
                                    CalendarCellView(day: day.day, isToday: day.isToday, isCurrentMonthDay: day.isCurrentMonthDay, isSunday: day.isSunday, weekday: 0)
                                        .onTapGesture {
//                                            viewModel.updateCalendarData(with: day.date)
                                            print(day.day,"tapped")
                                        }
                                }
                            }
                        }
                    }
                }
                
                ButtonView()
            }
            .navigationBarTitle(Text(viewModel.month, formatter: Date.calendarHeaderDateFormatter), displayMode: .inline)
            .navigationBarItems(leading: Button("Today", action: {
                //
            })
            )
            .navigationBarItems(trailing: Button(action: {
                //
            }) {
                Image(systemName: "line.horizontal.3")
            })
            .navigationBarItems(trailing: Button(action: {
                //
            }) {
                Image(systemName: "square.grid.3x3.square")
            })
        }
        .foregroundColor(.white)
    }
}
