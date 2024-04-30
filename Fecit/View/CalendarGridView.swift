import SwiftUI

struct CalendarGridView: View {
  @State private var month: Date = Date()
  @State private var clickedCurrentMonthDates: Date?
  @State private var visibleDaysOfNextMonth: Int?
  @ObservedObject var viewModel: CalendarViewModel
  
  var body: some View {
    calendarGridView
  }
  
  var calendarGridView: some View {
    let daysInMonth: Int = numberOfDays(in: month)
    let firstWeekday: Int = firstWeekdayOfMonth(in: month) - 1
    let lastDayOfMonthBefore = numberOfDays(in: previousMonth())
    return LazyVGrid(columns: Array(repeating: GridItem(), count: 7)) {
      ForEachDaysInMonth(daysInMonth: daysInMonth, firstWeekday: firstWeekday) { index in
        CalendarCellViewForRow(
          index: index,
          daysInMonth: daysInMonth,
          firstWeekday: firstWeekday,
          lastDayOfMonthBefore: lastDayOfMonthBefore,
          clickedCurrentMonthDates: self.$clickedCurrentMonthDates,
          getDate: self.getDate
        )
        .environmentObject(self.viewModel)
        .onTapGesture {
          if 0 <= index && index < daysInMonth {
            let date = self.getDate(for: index)
            self.clickedCurrentMonthDates = date
          }
        }
      }
    }
  }
  
  struct CalendarCellViewForRow: View {
    let index: Int
    let daysInMonth: Int
    let firstWeekday: Int
    let lastDayOfMonthBefore: Int
    @Binding var clickedCurrentMonthDates: Date?
    let getDate: (Int) -> Date
    
    @EnvironmentObject var viewModel: CalendarViewModel
    
    var body: some View {
      Group {
        if let prevMonthDate = Calendar.current.date(
          byAdding: .day,
          value: index + lastDayOfMonthBefore,
          to: viewModel.previousMonth()
        ) {
          let day = Calendar.current.component(.day, from: prevMonthDate)
          CalendarCellView(
            day: day,
            isToday: false,
            isCurrentMonthDay: false,
            isSunday: true
          )
        }
      }
    }
  }
  
  func ForEachDaysInMonth<Content: View>(daysInMonth: Int, firstWeekday: Int, content: @escaping (Int) -> Content) -> some View {
    ForEach(-firstWeekday ..< daysInMonth + visibleDaysOfNextMonth!, id: \.self) { index in
      content(index)
    }
  }
  
  func getDate(for index: Int) -> Date {
    let calendar = Calendar.current
    guard let firstDayOfMonth = calendar.date(
      from: DateComponents(
        year: calendar.component(.year, from: month),
        month: calendar.component(.month, from: month),
        day: 1
      )
    ) else {
      return Date()
    }
    var dateComponents = DateComponents()
    dateComponents.day = index
    let timeZone = TimeZone.current
    let offset = Double(timeZone.secondsFromGMT(for: firstDayOfMonth))
    dateComponents.second = Int(offset)
    let date = calendar.date(byAdding: dateComponents, to: firstDayOfMonth) ?? Date()
    return date
  }
  
  /// 해당 월에 존재하는 일자 수
  func numberOfDays(in date: Date) -> Int {
    return Calendar.current.range(of: .day, in: .month, for: date)?.count ?? 0
  }
  
  /// 해당 월의 첫 날짜가 갖는 해당 주의 몇번째 요일
  func firstWeekdayOfMonth(in date: Date) -> Int {
    let components = Calendar.current.dateComponents([.year, .month], from: date)
    let firstDayOfMonth = Calendar.current.date(from: components)!
    return Calendar.current.component(.weekday, from: firstDayOfMonth)
  }
  
  /// 이전 월 마지막 일자
  func previousMonth() -> Date {
    let components = Calendar.current.dateComponents([.year, .month], from: month)
    let firstDayOfMonth = Calendar.current.date(from: components)!
    let previousMonth = Calendar.current.date(byAdding: .month, value: -1, to: firstDayOfMonth)!
    return previousMonth
  }
}
