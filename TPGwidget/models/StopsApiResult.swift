import Foundation

/// Content of the StopsPage view fetched from the API.
struct StopsApiResult: Decodable {
    let error: String?
    let featured: [Stop]?
    let all: [Stop]?
    
    /// Loads the list of stops from the server.
    ///
    /// - Parameter success Callback called on success.
    /// - Parameter errorCallback Callback called on error.
    static func fetch(success: @escaping (StopsApiResult) -> Void, error errorCallback: @escaping (ApiError) -> Void) {
        let url: URL = URL(string: "https://tpg.nicolapps.ch/app/v3/stops.json")!
        
        URLSession.shared.dataTask(with: url) { data, response, err in
            guard let data = data else {
                print("Couldn’t access the API.")
                errorCallback(.cantConnect)
                return
            }
            
            do {
                let content = try JSONDecoder().decode(StopsApiResult.self, from: data)
                
                if content.error == nil {
                    success(content)
                } else {
                    errorCallback(.custom(message: content.error!))
                }
            } catch {
                print("Couldn’t decode the API response: \(error).")
                errorCallback(.cantDecode)
            }
        }.resume()
    }
}
