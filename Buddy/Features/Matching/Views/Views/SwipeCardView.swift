import SwiftUI

struct SwipeCardView: View {
    let profile: Profile
    let onSwipe: (SwipeAction) -> Void
    
    @State private var offset = CGSize.zero
    @State private var rotation: Double = 0
    @GestureState private var dragState = CGSize.zero
    
    private let swipeThreshold: CGFloat = 100
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                // Image Area
                ZStack {
                    LinearGradient(
                        colors: [Theme.Colors.accent, Theme.Colors.secondary],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    
                    Text(profile.pet.type.emoji)
                        .font(.system(size: 100))
                }
                .frame(height: geometry.size.height * 0.65)
                
                // Info Area
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
                    
                    HStack(spacing: 4) {
                        Text(profile.pet.type.emoji)
                        Text("\(profile.pet.name) • \(profile.pet.breed)")
                            .font(.subheadline)
                            .foregroundColor(Theme.Colors.primary)
                    }
                    
                    Text(profile.bio)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                    
                    Spacer()
                }
                .padding()
                .background(Color.white)
            }
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 10)
            .overlay(
                // Like/Nope Overlay
                ZStack {
                    if offset.width > 50 {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.green, lineWidth: 3)
                        VStack {
                            Image(systemName: "heart.fill")
                                .font(.system(size: 50))
                                .foregroundColor(.green)
                                .padding(.top, 40)
                            Spacer()
                        }
                    } else if offset.width < -50 {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.red, lineWidth: 3)
                        VStack {
                            Image(systemName: "xmark.circle.fill")
                                .font(.system(size: 50))
                                .foregroundColor(.red)
                                .padding(.top, 40)
                            Spacer()
                        }
                    }
                }
                .opacity(min(abs(offset.width) / 100.0, 1.0))
            )
            .offset(x: offset.width + dragState.width, y: offset.height + dragState.height)
            .rotationEffect(.degrees(Double(offset.width) / 10.0))
            .gesture(
                DragGesture()
                    .updating($dragState) { value, state, _ in
                        state = value.translation
                    }
                    .onEnded { value in
                        let draggedWidth = value.translation.width
                        
                        if abs(draggedWidth) > swipeThreshold {
                            // Swipe action
                            withAnimation(.easeOut(duration: 0.3)) {
                                offset = CGSize(
                                    width: draggedWidth > 0 ? 500 : -500,
                                    height: 0
                                )
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                if draggedWidth > 0 {
                                    onSwipe(.like)
                                } else {
                                    onSwipe(.reject)
                                }
                            }
                        } else {
                            // Return to center
                            withAnimation(.spring()) {
                                offset = .zero
                            }
                        }
                    }
            )
        }
    }
}
