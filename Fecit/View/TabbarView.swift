import SwiftUI

struct TabbarView: View {
  @State var tag: Int = 1
  
  var body: some View {
    TabView(selection: $tag) {
      Text("first Tab Content")
        .tabItem {
          Label("Favorites", systemImage: "star")
        }
        .tag(0)
      
      CalendarView(viewModel: CalendarViewModel())
        .tabItem {
          Label("Action", systemImage: "calendar")
        }
        .tag(1)
      
      Text("Third Tab Content")
        .tabItem {
          Label("Memo", systemImage: "folder")
        }
        .tag(2)
      
      Text("Fourth Tab Content")
        .tabItem {
          Label("Library", systemImage: "note")
        }
        .tag(3)
      
      Text("Fifth Tab Content")
        .tabItem {
          Label("More", systemImage: "square.grid.2x2")
        }
        .tag(4)
    }
    .background(.gray.opacity(0.2))
  }
}
