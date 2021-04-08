import Foundation

/// A public transit stop.
struct Stop: Decodable, Identifiable {
    let id: String // (stop code)
    let nameFormatted: String
    let nameRaw: String
    let lines: [Line]
    let geolocation: Geolocation?

    struct Geolocation: Codable {
        let latitude: Double
        let longitude: Double
    }
    
    static func normalizeForSearch(_ name: String) -> String {
        return name
            .lowercased()
            .folding(options: .diacriticInsensitive, locale: .current)
            .replacingOccurrences(of: "‘", with: "'")
            .replacingOccurrences(of: "[^a-z0-9]+", with: "", options: .regularExpression)
    }
    
    func nameMatches(_ normalizedQuery: String) -> Bool {
        return Stop.normalizeForSearch(nameFormatted).contains(normalizedQuery)
            || Stop.normalizeForSearch(nameRaw).contains(normalizedQuery)
    }
}
