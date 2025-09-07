import SwiftUI

enum Theme {
    enum Colors {
        static let primary = Color(red: 102/255, green: 126/255, blue: 234/255)
        static let secondary = Color(red: 118/255, green: 75/255, blue: 162/255)
        static let accent = Color(red: 240/255, green: 147/255, blue: 251/255)
        static let background = Color(red: 248/255, green: 249/255, blue: 250/255)
    }
    
    enum Fonts {
        static let largeTitle = Font.system(size: 34, weight: .bold, design: .rounded)
        static let title = Font.system(size: 28, weight: .bold)
        static let body = Font.system(size: 17)
    }
    
    enum Spacing {
        static let xs: CGFloat = 4
        static let sm: CGFloat = 8
        static let md: CGFloat = 16
        static let lg: CGFloat = 24
        static let xl: CGFloat = 32
    }
}
