import SwiftUI

/// Shows the icon of a line.
struct LineIcon: View {
    @Environment(\.colorScheme) var colorScheme
    
    let line: Line
    
    var body: some View {
        Text(line.name)
            .foregroundColor(line.foreground)
            .font(Font.custom("Helvetica Neue Bold", size: 20))
            .frame(width: 49, height: 34, alignment: .center)
            .background(line.background)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(Color("LineIconBorder"), lineWidth: hasBorder ? 1 : 0)
            )
            .cornerRadius(cornerRadius)
    }
    
    var cornerRadius: CGFloat { line.shape == .tpg ? 100 : 5 }
    var hasBorder: Bool { line.background == .white && colorScheme == .light }
}

struct LineIcon_Previews: PreviewProvider {
    static let lines = [
        Line(name: "6", background: Color(hex: "#0099CC"), foreground: Color.white, shape: .tpg, type: .bus),
        Line(name: "19", background: Color(hex: "#ffcc01"), foreground: Color.black, shape: .tpg, type: .bus),
        Line(name: "R", background: Color.white, foreground: Color.black, shape: .tpg, type: .bus),
        Line(name: "L4", background: Color(hex: "#E08932"), foreground: Color.white, shape: .rectangular, type: .lex)
    ]
    
    static var previews: some View {
        ForEach(lines, id: \.self) { line in
            LineIcon(line: line).previewLayout(.sizeThatFits)
        }
    }
}
