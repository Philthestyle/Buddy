import SwiftUI

struct LaunchScreen: View {
    @State private var isAnimating = false
    @State private var progress: Double = 0
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Theme.Colors.primary, Theme.Colors.secondary],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 30) {
                ZStack {
                    RoundedRectangle(cornerRadius: 35)
                        .fill(.white)
                        .frame(width: 140, height: 140)
                        .shadow(radius: 20)
                    
                    Text("🐾")
                        .font(.system(size: 70))
                        .scaleEffect(isAnimating ? 1.1 : 1.0)
                }
                .animation(
                    .easeInOut(duration: 1.5).repeatForever(autoreverses: true),
                    value: isAnimating
                )
                
                Text("Buddy")
                    .font(.system(size: 42, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                
                Text("L'amour au bout de la laisse")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.white.opacity(0.9))
                
                ProgressView(value: progress)
                    .progressViewStyle(LinearProgressViewStyle(tint: .white))
                    .frame(width: 200)
                    .scaleEffect(y: 2)
                    .padding(.top, 40)
            }
        }
        .onAppear {
            isAnimating = true
            withAnimation(.easeOut(duration: 3)) {
                progress = 1.0
            }
        }
    }
}
