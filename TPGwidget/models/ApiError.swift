import Foundation

/// An error obtained when fetching an API.
enum ApiError: Error {
    case cantConnect
    case cantDecode
    case custom(message: String)
    
    var formattedTitle: String {
        switch self {
        case .cantConnect:
            return "Connexion impossible"
        case .cantDecode:
            return "Chargement impossible"
        case .custom(message: _):
            return ""
        }
    }
    
    var formattedContent: String {
        switch self {
        case .cantConnect:
            return "TPGwidget n’a pas pu se connecter au serveur. La connexion à Internet fonctionne-t-elle ?"
        case .cantDecode:
            return "TPGwidget n’a pas pu décoder les données reçues. L’application est-elle à jour ?"
        case .custom(message: let message):
            return message
        }
    }
}
