import SwiftUI

struct MessagesListScreen: View {
    var body: some View {
        VStack {
            Text("💬")
                .font(.system(size: 80))
            Text("Messages")
                .font(.largeTitle)
                .fontWeight(.bold)
            Text("Vos conversations apparaîtront ici")
                .foregroundColor(.secondary)
        }
    }
}
