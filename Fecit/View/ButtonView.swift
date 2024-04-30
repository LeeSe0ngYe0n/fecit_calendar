import SwiftUI

struct ButtonView: View {
  var tappedAddContentButton: () -> Void
  
  var body: some View {
    Button(action: {
      tappedAddContentButton()
    }) {
      HStack{
        Label("New Action", systemImage: "square.and.pencil")
        Rectangle()
          .frame(width: 1, height: 20)
        Image(systemName: "chevron.up")
      }
      .foregroundColor(.white)
      .padding()
      .background(Color.indigo)
      .clipShape(Capsule())
    }
  }
}
