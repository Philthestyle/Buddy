import SwiftUI

struct ProfileScreen: View {
    var body: some View {
        VStack {
            Text("👤")
                .font(.system(size: 80))
            Text("Mon Profil")
                .font(.largeTitle)
                .fontWeight(.bold)
            Text("Gérez votre profil et celui de votre animal")
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding()
        }
    }
}
