import Foundation

/// A public transit stop.
struct Stop: Decodable, Identifiable {
    let id: String // (stop code)
    let nameFormatted: String
    let nameRaw: String
    let lines: [Line]
    let geolocation: Geolocation

    struct Geolocation: Codable {
        let latitude: Double
        let longitude: Double
    }
}
