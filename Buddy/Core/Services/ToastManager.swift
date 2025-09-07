import SwiftUI

@MainActor
final class ToastManager: ObservableObject {
    enum ToastStyle {
        case info, success, warning, error
        
        var backgroundColor: Color {
            switch self {
            case .info: return .blue
            case .success: return .green
            case .warning: return .orange
            case .error: return .red
            }
        }
    }
    
    struct Toast: Identifiable, Equatable {
        let id = UUID()
        let message: String
        let style: ToastStyle
        let duration: TimeInterval
        
        // Conformance à Equatable
        static func == (lhs: Toast, rhs: Toast) -> Bool {
            lhs.id == rhs.id
        }
    }
    
    @Published var toasts: [Toast] = []
    
    func show(_ message: String, style: ToastStyle = .info, duration: TimeInterval = 2.0) {
        let toast = Toast(message: message, style: style, duration: duration)
        toasts.append(toast)
        
        Task {
            try await Task.sleep(nanoseconds: UInt64(duration * 1_000_000_000))
            toasts.removeAll { $0.id == toast.id }
        }
    }
}

struct ToastOverlay: View {
    @EnvironmentObject var toastManager: ToastManager
    
    var body: some View {
        VStack {
            ForEach(toastManager.toasts) { toast in
                ToastView(toast: toast)
                    .transition(.move(edge: .top).combined(with: .opacity))
            }
            Spacer()
        }
        .animation(.easeInOut, value: toastManager.toasts)
    }
}

struct ToastView: View {
    let toast: ToastManager.Toast
    
    var body: some View {
        Text(toast.message)
            .foregroundColor(.white)
            .padding()
            .background(toast.style.backgroundColor)
            .cornerRadius(10)
            .padding(.horizontal)
            .padding(.top, 50)
    }
}
