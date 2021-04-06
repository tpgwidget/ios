import SwiftUI

/// Shows several line icons in a grid.
struct LinesGrid: View {
    let lines: [Line]
    
    let layout = [
        GridItem(.adaptive(minimum: 50, maximum: 50))
    ]
    
    var body: some View {
        LazyVGrid(columns: layout, spacing: 10) {
            ForEach(lines, id: \.self) { line in
                LineIcon(line: line)
            }
        }
    }
}

struct LinesGrid_Previews: PreviewProvider {
    static var lines = [
        Line(name: "14", background: Color(hex: "#663399"), foreground: Color.white, shape: .tpg, type: .tram),
        Line(name: "18", background: Color(hex: "#cc3399"), foreground: Color.white, shape: .tpg, type: .tram),
        Line(name: "57", background: Color(hex: "#80c3b5"), foreground: Color.black, shape: .tpg, type: .bus),
    ]
    
    static var previews: some View {
        LinesGrid(lines: lines).previewLayout(.sizeThatFits)
    }
}
