import SwiftUI

struct AddContentView: View {
  @Binding var clickDate: String?
  @State private var title: String = ""
  @State private var content: String = ""
  @Environment(\.dismiss) private var dismiss
  @ObservedObject var viewModel: CalendarViewModel
  @State var addText: Bool = false
  
  var body: some View {
    NavigationStack {
      VStack {
        TextField("Title", text: $title)
          .background(Color(.secondarySystemBackground))
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .cornerRadius(10)
          .foregroundColor(.black)
          .padding()
          .onChange(of: title) { oldValue, newValue in
            if newValue != "" {
              addText = true
            } else {
              addText = false
            }
          }
        TextEditor(text: $content)
          .background(Color(.secondarySystemBackground))
          .cornerRadius(15)
          .padding()
          .foregroundColor(.black)
          .multilineTextAlignment(.leading)
      }
      .background(Color.indigo.edgesIgnoringSafeArea(.all))
      .navigationBarTitle(Text("선택한 날짜: \(clickDate ?? Date().formattedDateString)"), displayMode: .inline)
      .navigationBarItems(leading: Text("취소").onTapGesture {
        dismiss()
      }
        .foregroundColor(.red.opacity(0.7))
      )
      .navigationBarItems(trailing: Text("추가")
        .onTapGesture {
          guard title != "" else { return }
          let event = Event(date: clickDate ?? Date().formattedDateString, title: title)
          viewModel.addEvent(event)
          dismiss()
        }
        .foregroundColor(addText ? .white : .white.opacity(0.2))
      )
      
    }
  }
}
