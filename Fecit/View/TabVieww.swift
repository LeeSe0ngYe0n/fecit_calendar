import SwiftUI

struct TabVieww: View {
    var body: some View {
        TabView {
            CalendarView(viewModel: CalendarViewModel())
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Calendar")
                }
            
            Text("Second Tab Content")
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Second")
                }
            
            Text("Third Tab Content")
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Third")
                }
            
            Text("Fourth Tab Content")
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Fourth")
                }
            
            Text("Fifth Tab Content")
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Fifth")
                }
        }
    }
}

#Preview {
    TabVieww()
}
