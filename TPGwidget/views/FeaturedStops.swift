import SwiftUI

/// Shows the grid of featured stops.
struct FeaturedStops: View {
    let stops: [Stop]
    let spacing: CGFloat = 8
    let forceTwoColumns: Bool // set to true on small screens to avoid having one column
    
    let onStopSelected: (Stop) -> Void

    var body: some View {
        LazyVGrid(
            columns: forceTwoColumns
                ? Array.init(repeating: GridItem(.flexible(), spacing: spacing), count: 2)
                : [GridItem(.adaptive(minimum: 165), spacing: spacing)],
            spacing: spacing
        ) {
            ForEach(stops) { stop in
                Button(stop.name.corrected) {
                    onStopSelected(stop)
                }
                .buttonStyle(FeaturedStopButtonStyle())
            }
        }
    }
}

struct FeaturedStopButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        
        ZStack(alignment: .bottomLeading) {
            LinearGradient(
                gradient: Gradient(colors: [Color("ButtonGradientTop"), Color("ButtonGradientBottom")]),
                startPoint: .top,
                endPoint: .bottom
            )
            .overlay(Color.black.opacity(configuration.isPressed ? 0.15 : 0))
            .mask(RoundedRectangle(cornerRadius: 8, style: .continuous))
            .shadow(color: Color("ButtonShadow"), radius: 5, x: 0, y: 4)
            .animation(.easeInOut(duration: 0.2))
            
            configuration.label
                .font(.system(size: 14, weight: .semibold, design: .default))
                .lineSpacing(0)
                .foregroundColor(.white)
                .padding(12)
        }
        .frame(minHeight: 20)
        .hoverEffect(.lift)
        
        .scaleEffect(configuration.isPressed ? 1.06 : 1)
        .animation(.easeInOut(duration: 0.2))
    }
}



struct FeaturedStops_Previews: PreviewProvider {
    static let sampleStops = [
        Stop(
            id: "CVIN",
            name: Stop.Name(formatted: "Gare Cornavin", corrected: "Gare Cornavin", raw: "Gare Cornavin"),
            lines: [],
            geolocation: nil
        ),
        Stop(
            id: "BAIR",
            name: Stop.Name(formatted: "Bel-Air", corrected: "Bel-Air", raw: "Bel-Air"),
            lines: [],
            geolocation: nil
        ),
        Stop(
            id: "RIVE",
            name: Stop.Name(formatted: "Rive", corrected: "Rive", raw: "Rive"),
            lines: [],
            geolocation: nil
        ),
        Stop(
            id: "AERO",
            name: Stop.Name(formatted: "Genève-Aéroport", corrected: "Genève-Aéroport", raw: "Genève-Aéroport"),
            lines: [],
            geolocation: nil
        ),
        Stop(
            id: "COUT",
            name: Stop.Name(formatted: "Coutance", corrected: "Coutance", raw: "Coutance"),
            lines: [],
            geolocation: nil
        ),
        Stop(
            id: "PLPA",
            name: Stop.Name(formatted: "Plainpalais", corrected: "Plainpalais", raw: "Plainpalais"),
            lines: [],
            geolocation: nil
        ),
        Stop(
            id: "NATI",
            name: Stop.Name(formatted: "Nations", corrected: "Nations", raw: "Nations"),
            lines: [],
            geolocation: nil
        ),
        Stop(
            id: "JOCT",
            name: Stop.Name(formatted: "Jonction", corrected: "Jonction", raw: "Jonction"),
            lines: [],
            geolocation: nil
        ),
        Stop(
            id: "CRGE",
            name: Stop.Name(formatted: "Carouge-Rondeau", corrected: "Carouge-Rondeau", raw: "Carouge-Rondeau"),
            lines: [],
            geolocation: nil
        ),
        Stop(
            id: "ESRT",
            name: Stop.Name(formatted: "Les Esserts", corrected: "Les Esserts", raw: "Les Esserts"),
            lines: [],
            geolocation: nil
        ),
        Stop(
            id: "HOPI",
            name: Stop.Name(formatted: "Hôpital", corrected: "Hôpital", raw: "Hôpital"),
            lines: [],
            geolocation: nil
        ),
        Stop(
            id: "BHET",
            name: Stop.Name(formatted: "Lancy-Bachet-Gare", corrected: "Lancy-Bachet-Gare", raw: "Lancy-Bachet-Gare"),
            lines: [],
            geolocation: nil
        )
    ]
    
    static var previews: some View {
        NavigationView {
            FeaturedStops(stops: sampleStops, forceTwoColumns: true) { _ in }
                .padding()
        }
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (1st generation)"))
        
        NavigationView {
            FeaturedStops(stops: sampleStops, forceTwoColumns: false) { _ in }
                .padding()
        }
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (2nd generation)"))
        
        NavigationView {
            FeaturedStops(stops: sampleStops, forceTwoColumns: false) { _ in }
                .padding()
        }
            .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
            .preferredColorScheme(.dark)
        
        FeaturedStops(stops: sampleStops, forceTwoColumns: false) { _ in }
            .padding()
            .previewDevice(PreviewDevice(rawValue: "iPad Air (4th generation)"))
    }
}

