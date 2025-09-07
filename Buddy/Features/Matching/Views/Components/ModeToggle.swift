import SwiftUI

struct ModeToggleView: View {
    @Binding var selectedMode: MatchMode
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(MatchMode.allCases, id: \.self) { mode in
                Button(action: {
                    withAnimation {
                        selectedMode = mode
                    }
                }) {
                    HStack {
                        Text(mode.icon)
                        Text(mode.displayName)
                    }
                    .foregroundColor(selectedMode == mode ? .white : .gray)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background(
                        selectedMode == mode ?
                        AnyView(LinearGradient(
                            colors: [Theme.Colors.primary, Theme.Colors.secondary],
                            startPoint: .leading,
                            endPoint: .trailing
                        )) :
                        AnyView(Color.clear)
                    )
                    .cornerRadius(25)
                }
            }
        }
        .padding(4)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(29)
    }
}
