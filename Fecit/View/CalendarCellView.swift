import SwiftUI

struct CalendarCellView: View {
  private var day: Int
  private var isToday: Bool
  private var isCurrentMonthDay: Bool
  private var isSunday: Bool
  private var eventTitles: [String]?
  private let color: [Color] = [.red, .orange, .yellow]
  
  init(
    day: Int,
    isToday: Bool = false,
    isCurrentMonthDay: Bool = true,
    isSunday: Bool,
    eventsForDay: [String]? = nil
  ) {
    self.day = day
    self.isToday = isToday
    self.isCurrentMonthDay = isCurrentMonthDay
    self.isSunday = isSunday
    self.eventTitles = eventsForDay
  }
  
  var body: some View {
    VStack {
      Text(String(day))
        .font(.body)
        .foregroundColor(isCurrentMonthDay ? (isSunday ? .red : .black) : .gray)
        .padding(4)
        .background(
          Circle()
            .fill(Date().today == day ? .blue.opacity(0.4) : .clear)
        )
      ZStack {
        if let titles = eventTitles, !titles.isEmpty {
          VStack {
            ForEach(Array(titles.prefix(3).enumerated()), id: \.element) { (index, title ) in
              Text(title)
                .font(.caption)
                .foregroundColor(color[index])
                .padding(.horizontal, 5)
                .padding(.vertical, 2)
                .frame(maxWidth: .infinity)
                .background(color[index].opacity(0.2))
                .cornerRadius(8)
            }
            if titles.count > 3 {
              Text("...")
                .font(.caption)
                .foregroundColor(.green)
                .padding(.horizontal, 5)
                .padding(.vertical, 2)
                .frame(maxWidth: .infinity)
                .background(Color.green.opacity(0.2))
                .cornerRadius(8)
            }
            Spacer()
          }
        }
      }
      .frame(height: 100)
      .frame(maxWidth: .infinity)
    }
  }
}
