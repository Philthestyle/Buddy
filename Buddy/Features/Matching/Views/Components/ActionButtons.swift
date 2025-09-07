import SwiftUI

struct ActionButtonsView: View {
    let onReject: () -> Void
    let onSuperLike: () -> Void
    let onLike: () -> Void
    
    var body: some View {
        HStack(spacing: 30) {
            Button(action: onReject) {
                Circle()
                    .fill(Color.white)
                    .frame(width: 60, height: 60)
                    .overlay(
                        Image(systemName: "xmark")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.red)
                    )
                    .shadow(radius: 5)
            }
            
            Button(action: onSuperLike) {
                Circle()
                    .fill(LinearGradient(
                        colors: [Theme.Colors.primary, Theme.Colors.secondary],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
                    .frame(width: 50, height: 50)
                    .overlay(
                        Image(systemName: "star.fill")
                            .foregroundColor(.white)
                    )
                    .shadow(radius: 5)
            }
            
            Button(action: onLike) {
                Circle()
                    .fill(Color.white)
                    .frame(width: 60, height: 60)
                    .overlay(
                        Image(systemName: "heart.fill")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.green)
                    )
                    .shadow(radius: 5)
            }
        }
    }
}
