import SwiftUI

struct CalendarView: View {
  @ObservedObject var viewModel: CalendarViewModel
  @State private var clickDate: String?
  @State private var showModal = false
  
  init(viewModel: CalendarViewModel, clickDate: String? = nil, showModal: Bool = false) {
    self.viewModel = viewModel
    self._clickDate = State(initialValue: clickDate)
    self._showModal = State(initialValue: showModal)
    UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
  }
  
  var body: some View {
    NavigationStack {
      ZStack(alignment: .bottom ) {
        VStack {
          HeaderView()
          ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(), count: 7)) {
              ForEach(viewModel.getCalendarData(), id: \.self) { week in
                ForEach(week, id: \.date) { day in
                  CalendarCellView(
                    day: day.day,
                    isToday: day.isToday,
                    isCurrentMonthDay: day.isCurrentMonthDay,
                    isSunday: day.isSunday,
                    eventsForDay: viewModel.events(forDate: day.date).map { $0.title }
                  )
                  .onTapGesture {
                    clickDate = day.date.formattedDateString
                    print(day.date.formattedDateString,"tapped")
                  }
                }
              }
            }
          }
        }
        
        ButtonView {
          showModal = true
        }
        .padding(.bottom, 15)
        .sheet(isPresented: $showModal, content: {
          AddContentView(clickDate: $clickDate, viewModel: viewModel)
        })
      }
      .navigationBarTitle(Text(viewModel.month, formatter: Date.calendarHeaderDateFormatter), displayMode: .inline)
      .navigationBarItems(leading: Text("Today"))
      .navigationBarItems(trailing: Image(systemName: "line.horizontal.3"))
      .navigationBarItems(trailing: Image(systemName: "square.grid.3x3.square"))
    }
    .foregroundColor(.white)
  }
}
