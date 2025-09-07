import SwiftUI

struct SwipeCardView: View {
    let profile: Profile
    @State private var offset = CGSize.zero
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                LinearGradient(
                    colors: [Theme.Colors.accent, Theme.Colors.secondary],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                
                Text(profile.pet.type.emoji)
                    .font(.system(size: 100))
            }
            .frame(height: 400)
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(profile.name)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("\(profile.age)")
                        .font(.title2)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                }
                
                HStack {
                    Text(profile.pet.type.emoji)
                    Text("\(profile.pet.name) • \(profile.pet.breed)")
                        .foregroundColor(Theme.Colors.primary)
                }
                
                Text(profile.bio)
                    .font(.body)
                    .foregroundColor(.secondary)
            }
            .padding()
        }
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
        .offset(offset)
        .gesture(
            DragGesture()
                .onChanged { value in
                    offset = value.translation
                }
                .onEnded { _ in
                    withAnimation {
                        offset = .zero
                    }
                }
        )
    }
}
