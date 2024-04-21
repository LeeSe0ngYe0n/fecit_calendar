import SwiftUI

struct ButtonView: View {
    var body: some View {
        ZStack {
            Color.clear.opacity(0.2)
                .ignoresSafeArea()
            VStack {
                Spacer()
                HStack {
                    Button(action: {
                        //
                    }) {
                        Label("New Action", systemImage: "square.and.pencil")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.indigo)
                            .cornerRadius(30)
                    }
                }
            }.padding(.bottom, 40)
        }
    }
}
