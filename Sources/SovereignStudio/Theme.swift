import SwiftUI

// MARK: - Color Hex Initializer
extension Color {
    init(hex: String) {
        let cleanHex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: cleanHex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch cleanHex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// MARK: - Sovereign Bare-Metal Mainframe Design System Tokens
extension Color {
    // Backgrounds
    static let sbbBackground = Color(hex: "#0D0D12")
    static let sbbSurface = Color(hex: "#16161E")
    static let sbbSurfaceElevated = Color(hex: "#1A1A24")
    
    // Crisp Hardware Borders
    static let sbbBorder = Color(hex: "#232330")
    static let sbbBorderSubtle = Color(hex: "#2A2A38")
    
    // High-Tech Cyberpunk Accents
    static let sbbElectricBlue = Color(hex: "#0052FF")
    static let sbbNeonCyan = Color(hex: "#00D2FF")
    static let sbbCrimsonLive = Color(hex: "#FF3366")
    static let sbbNeonMagenta = Color(hex: "#B533FF")
    static let sbbActiveGreen = Color(hex: "#00E676")
    static let sbbWarningAmber = Color(hex: "#FFB020")
    
    // Typography Colors
    static let sbbTextPrimary = Color(hex: "#F4F4F8")
    static let sbbTextSecondary = Color(hex: "#8E8EA0")
    static let sbbTextMuted = Color(hex: "#5A5A6E")
}

// MARK: - Pro Hardware Container Modifier
struct ProHardwareCard: ViewModifier {
    var backgroundColor: Color = .sbbSurface
    var borderColor: Color = .sbbBorder
    var cornerRadius: CGFloat = 3.0
    var padding: CGFloat = 12.0
    
    func body(content: Content) -> some View {
        content
            .padding(padding)
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(borderColor, lineWidth: 1)
            )
    }
}

extension View {
    func proCard(bg: Color = .sbbSurface, border: Color = .sbbBorder, radius: CGFloat = 3.0, padding: CGFloat = 12.0) -> some View {
        self.modifier(ProHardwareCard(backgroundColor: bg, borderColor: border, cornerRadius: radius, padding: padding))
    }
}

// MARK: - Live Pulsing Indicator Dot
struct LivePulseDot: View {
    var color: Color = .sbbActiveGreen
    var size: CGFloat = 8.0
    @State private var isPulsing = false
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(color.opacity(isPulsing ? 0.0 : 0.6), lineWidth: 1.5)
                .frame(width: size * (isPulsing ? 2.2 : 1.0), height: size * (isPulsing ? 2.2 : 1.0))
                .animation(Animation.easeOut(duration: 1.4).repeatForever(autoreverses: false), value: isPulsing)
            
            Circle()
                .fill(color)
                .frame(width: size, height: size)
        }
        .onAppear {
            isPulsing = true
        }
    }
}
