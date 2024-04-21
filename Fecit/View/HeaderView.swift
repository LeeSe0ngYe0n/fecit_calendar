import SwiftUI

struct HeaderView: View {
    var body: some View {
            VStack {
                HStack {
                    ForEach(0..<7, id: \.self) { index in
                        Text(Date.weekdaySymbols[index].uppercased())
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                    }
                }
                .background(Color.indigo)
            }
        }
}
