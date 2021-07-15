import Foundation

/// A public transit stop.
struct Stop: Decodable, Identifiable {
    let id: String // (stop code)
    let name: Name
    let lines: [Line]
    let geolocation: Geolocation?
    
    struct Name: Codable {
        let formatted: String
        let corrected: String
        let raw: String
    }

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
    
    static var empty: Stop {
        Stop(id: "", name: Name(formatted: "", corrected: "", raw: ""), lines: [], geolocation: nil)
    }
    
    func nameMatches(_ normalizedQuery: String) -> Bool {
        return Stop.normalizeForSearch(name.corrected).contains(normalizedQuery)
            || Stop.normalizeForSearch(name.raw).contains(normalizedQuery)
    }
}
