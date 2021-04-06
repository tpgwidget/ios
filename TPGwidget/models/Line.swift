import SwiftUI

/// A public transit line.
struct Line: Decodable {
    let name: String
    let background: Color
    let foreground: Color
    let shape: Line.Shape
    
    enum Shape: String, Codable { case tpg, rectangular }
}

/// Defaults line shapes to rectangular if the line shape isn’t recognized.
extension Line.Shape {
    public init(from decoder: Decoder) throws {
        self = try Line.Shape(
            rawValue: decoder.singleValueContainer().decode(RawValue.self)
        ) ?? .rectangular
    }
}

/// Makes it possible to decode a color from a hex string (such as "#FF6600").
extension Color: Decodable {
    /// Init a color from a decoder.
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let hex = try container.decode(String.self)
        self.init(hex: hex)
    }
    
    /// Init a color from a hex value.
    private init(hex: String) { // https://stackoverflow.com/a/56874327/4652564
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
