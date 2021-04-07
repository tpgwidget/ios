import SwiftUI

struct RoundedButtonStyle: ButtonStyle {
    enum Variant { case normal, inversed }
    let variant: Variant
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding(.vertical, 15)
            .padding(.horizontal, 25)
            .background(variant == .inversed ? Color.white : Color("AccentColor"))
            .overlay(Color.black.opacity(configuration.isPressed ? 0.1 : 0))
            
            .foregroundColor(variant == .inversed ? Color("AccentColor") : .white)
            .font(.system(size: 20, weight: .semibold))
            .hoverEffect(.lift)
            
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            .animation(.easeInOut(duration: 0.2))
    }
}
