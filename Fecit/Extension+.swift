import SwiftUI

extension Date {
  static let weekdaySymbols: [String] = Calendar.current.shortWeekdaySymbols
  
  var today: Int {
    let now = Date()
    let components = Calendar.current.dateComponents( [.day], from: now)
    return components.day!
  }
  
  var formattedDateString: String {
    let formatter = DateFormatter()
    formatter.dateFormat = "YYYY-MM-dd"
    return formatter.string(from: self)
  }
  
  static let calendarHeaderDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = " MMMM YYYY"
    return formatter
  }()
}
