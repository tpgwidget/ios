import Foundation

/// Content of the StopsPage view fetched from the API.
struct StopsAPIResult: Decodable {
    let all: [Stop]
    
    /// Loads the list of stops from the server.
    ///
    /// - Parameter success Callback called on success.
    /// - Parameter errorCallback Callback called on error.
    static func fetch(success: @escaping (StopsAPIResult) -> Void, error errorCallback: @escaping () -> Void) {
        let url: URL = URL(string: "https://tpg.nicolapps.ch/app/v3/stops.json")!
        
        URLSession.shared.dataTask(with: url) { data, response, err in
            guard let data = data else {
                print("Couldn’t access the API.")
                errorCallback()
                return
            }
            
            do {
                let content = try JSONDecoder().decode(StopsAPIResult.self, from: data)
                success(content)
            } catch {
                print("Couldn’t decode the API response: \(error).")
                errorCallback()
            }
        }.resume()
    }
}
