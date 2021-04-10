import SwiftUI

struct RoundedButtonStyle: ButtonStyle {
    enum Variant {
        case normal, inversed
        
        @ViewBuilder
        var background: some View {
            switch self {
            case .normal:
                LinearGradient(gradient: Gradient(colors: [Color("ButtonGradientTop"), Color("ButtonGradientBottom")]), startPoint: .top, endPoint: .bottom)
            case .inversed:
                Color.white
            }
        }
        
        var foregroundColor: Color {
            switch self {
            case .normal:
                return Color.white
            case .inversed:
                return Color("AccentColor")
            }
        }
    }
    
    let variant: Variant
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding(.vertical, 15)
            .padding(.horizontal, 25)
            .background(variant.background)
            .overlay(Color.black.opacity(configuration.isPressed ? 0.1 : 0))
            
            .foregroundColor(variant.foregroundColor)
            .font(.system(size: 20, weight: .semibold))
            .hoverEffect(.lift)
            
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            .animation(.easeInOut(duration: 0.2))
    }
}

struct RoundedButtonStyle_Previews: PreviewProvider {
    static var variants: [RoundedButtonStyle.Variant] = [.normal, .inversed]
    
    static var previews: some View {
        ForEach(variants, id: \.self) { variant in
            Button("Sample Text", action: {})
                .buttonStyle(RoundedButtonStyle(variant: variant))
                .padding()
                .background(variant == .inversed ? Color("AccentColor") : Color.white)
                .previewLayout(.sizeThatFits)
                .previewDisplayName(String(describing: variant))
        }
    }
}
