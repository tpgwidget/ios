import SwiftUI

struct StopPage: View {
    let stop: Stop
    
    var body: some View {
        VStack {
            LinesGrid(lines: stop.lines).padding(.vertical)
            
            Spacer()
            
            HStack {
                Button(action: install, label: {
                    Text("Installer")
                })
                .buttonStyle(RoundedButtonStyle(variant: .normal))
                .padding()
            }
        }
        .navigationTitle(Text(stop.nameRaw))
    }
    
    func install() {
        let url = URL(string: "https://tpg.nicolapps.ch/\(stop.id)/")!
        UIApplication.shared.open(url)
    }
}

struct StopPage_Previews: PreviewProvider {
    static var lines = [
        Line(name: "12", background: Color(hex: "#ff9901"), text: Color.black, shape: .tpg, type: .tram),
        Line(name: "18", background: Color(hex: "#cc3399"), text: Color.white, shape: .tpg, type: .tram),
        Line(name: "23", background: Color(hex: "#cc3399"), text: Color.white, shape: .tpg, type: .bus),
        Line(name: "42", background: Color(hex: "#80c3b5"), text: Color.black, shape: .tpg, type: .bus),
        Line(name: "43", background: Color(hex: "#80c3b5"), text: Color.black, shape: .tpg, type: .bus),
        Line(name: "46", background: Color(hex: "#00a19a"), text: Color.white, shape: .tpg, type: .bus),
        Line(name: "62", background: Color(hex: "#eb6ca3"), text: Color.white, shape: .tpg, type: .bus),
        Line(name: "D", background: Color(hex: "#ff9999"), text: Color.black, shape: .tpg, type: .bus),
        Line(name: "L1", background: Color(hex: "#DF5046"), text: Color.white, shape: .rectangular, type: .train),
        Line(name: "L2", background: Color(hex: "#1691C3"), text: Color.white, shape: .rectangular, type: .train),
        Line(name: "L3", background: Color(hex: "#4A9844"), text: Color.white, shape: .rectangular, type: .train),
        Line(name: "L4", background: Color(hex: "#E08932"), text: Color.white, shape: .rectangular, type: .train),
    ]
    
    static var stop = Stop(id: "BHET", nameFormatted: "Lancy-Bachet<small>-Gare</small>", nameRaw: "Lancy-Bachet-Gare", lines: lines, geolocation: nil)
    
    static var previews: some View {
        NavigationView {
            StopPage(stop: stop)
        }
    }
}
