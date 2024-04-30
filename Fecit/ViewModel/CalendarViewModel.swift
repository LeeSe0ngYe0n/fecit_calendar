import Foundation

class CalendarViewModel: ObservableObject {
  @Published var month: Date = Date()
  @Published var clickedCurrentMonthDates: Date?
  @Published var events: [Event] = []
  
  init(month: Date = Date(), clickedCurrentMonthDates: Date? = nil) {
    self.month = month
  }
  
  func getCalendarData() -> [[CalendarDate]] {
    var calendarData: [[CalendarDate]] = []
    
    let daysInMonth = numberOfDays(in: month)
    let firstWeekday = firstWeekdayOfMonth(in: month) - 1
    let lastDayOfMonthBefore = numberOfDays(in: previousMonth())
    let numberOfRows = Int(ceil(Double(daysInMonth + firstWeekday) / 7.0))
    let visibleDaysOfNextMonth = numberOfRows * 7 - (daysInMonth + firstWeekday)
    var calendarDates: [CalendarDate] = []
    
    for index in -firstWeekday ..< daysInMonth + visibleDaysOfNextMonth {
      if index > -1 && index < daysInMonth {
        let date = getDate(for: index)
        let day = Calendar.current.component(.day, from: date)
        let isToday = date.formattedDateString == Date().formattedDateString
        let isSunday = (firstWeekday + index) % 7 == 0
        
        let calendarDate = CalendarDate(date: date, day: day, isToday: isToday, isCurrentMonthDay: true, isSunday: isSunday)
        calendarDates.append(calendarDate)
      } else if let prevMonthDate = Calendar.current.date(
        byAdding: .day,
        value: index + lastDayOfMonthBefore,
        to: previousMonth()
      ) {
        let day = Calendar.current.component(.day, from: prevMonthDate)
        let isSunday = (firstWeekday + index) % 7 == 0
        
        let calendarDate = CalendarDate(date: prevMonthDate, day: day, isToday: false, isCurrentMonthDay: false, isSunday: isSunday)
        calendarDates.append(calendarDate)
      }
    }
    
    for i in 0..<numberOfRows {
      calendarData.append(Array(calendarDates[i * 7 ..< i * 7 + 7]))
    }
    
    return calendarData
  }
  
  // 이전 월 마지막 일자
  func previousMonth() -> Date {
    let components = Calendar.current.dateComponents([.year, .month], from: month)
    let firstDayOfMonth = Calendar.current.date(from: components)!
    let previousMonth = Calendar.current.date(byAdding: .month, value: -1, to: firstDayOfMonth)!
    return previousMonth
  }
  
  // 특정 해당 날짜
  private func getDate(for index: Int) -> Date {
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
  
  // 해당 월에 존재하는 일자 수
  private func numberOfDays(in date: Date) -> Int {
    return Calendar.current.range(of: .day, in: .month, for: date)?.count ?? 0
  }
  
  // 해당 월의 첫 날짜가 갖는 해당 주의 몇번째 요일
  private func firstWeekdayOfMonth(in date: Date) -> Int {
    let components = Calendar.current.dateComponents([.year, .month], from: date)
    let firstDayOfMonth = Calendar.current.date(from: components)!
    return Calendar.current.component(.weekday, from: firstDayOfMonth)
  }
  
  // 이벤트 추가 함수
  func addEvent(_ event: Event) {
    self.events.append(event)
    print("Event added:", event)
  }
  
  // 날짜에 해당하는 이벤트 가져오기
  func events(forDate date: Date) -> [Event] {
    let dateString = date.formattedDateString
    return events.filter { $0.date == dateString }
  }
}
