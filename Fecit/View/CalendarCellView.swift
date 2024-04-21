import SwiftUI

struct CalendarCellView: View {
    private var day: Int
    private var isToday: Bool
    private var isCurrentMonthDay: Bool
    private var isSunday: Bool
    private var weekday: Int
    
    private var textColor: Color {
        if isCurrentMonthDay && isSunday {
            return Color.red
        } else if isCurrentMonthDay {
            return Color.black
        } else {
            return Color.gray
        }
    }
    
    private var backgroundColor: Color {
        if isToday {
            return Color.indigo
        } else {
            return Color.white
        }
    }
    
    init(
        day: Int,
        isToday: Bool = false,
        isCurrentMonthDay: Bool = true,
        isSunday: Bool,
        weekday: Int
        
    ) {
        self.day = day
        self.isToday = isToday
        self.isCurrentMonthDay = isCurrentMonthDay
        self.isSunday = isSunday
        self.weekday = weekday 
    }
    
    var body: some View {
        VStack {
            Circle()
                .stroke(backgroundColor, lineWidth: 1.5)
                .overlay(Text(String(day)))
                .foregroundColor(textColor)
            
            Spacer()
        }
        .frame(height: 80)
    }
}
