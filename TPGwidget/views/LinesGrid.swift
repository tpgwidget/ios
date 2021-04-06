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
        Line(name: "12", background: Color(hex: "#ff9901"), foreground: Color.black, shape: .tpg, type: .tram),
        Line(name: "18", background: Color(hex: "#cc3399"), foreground: Color.white, shape: .tpg, type: .tram),
        Line(name: "23", background: Color(hex: "#cc3399"), foreground: Color.white, shape: .tpg, type: .bus),
        Line(name: "42", background: Color(hex: "#80c3b5"), foreground: Color.black, shape: .tpg, type: .bus),
        Line(name: "43", background: Color(hex: "#80c3b5"), foreground: Color.black, shape: .tpg, type: .bus),
        Line(name: "46", background: Color(hex: "#00a19a"), foreground: Color.white, shape: .tpg, type: .bus),
        Line(name: "62", background: Color(hex: "#eb6ca3"), foreground: Color.white, shape: .tpg, type: .bus),
        Line(name: "D", background: Color(hex: "#ff9999"), foreground: Color.black, shape: .tpg, type: .bus),
        Line(name: "L1", background: Color(hex: "#DF5046"), foreground: Color.white, shape: .rectangular, type: .train),
        Line(name: "L2", background: Color(hex: "#1691C3"), foreground: Color.white, shape: .rectangular, type: .train),
        Line(name: "L3", background: Color(hex: "#4A9844"), foreground: Color.white, shape: .rectangular, type: .train),
        Line(name: "L4", background: Color(hex: "#E08932"), foreground: Color.white, shape: .rectangular, type: .train),
    ]
    
    static var previews: some View {
        LinesGrid(lines: lines).previewLayout(.sizeThatFits)
    }
}
