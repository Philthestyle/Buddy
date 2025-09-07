import SwiftUI

struct WalksScreen: View {
    var body: some View {
        VStack {
            Text("🗺️")
                .font(.system(size: 80))
            Text("Balades")
                .font(.largeTitle)
                .fontWeight(.bold)
            Text("Bientôt disponible")
                .foregroundColor(.secondary)
        }
    }
}
