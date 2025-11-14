import UIKit

enum CharacterStyle: String, Codable {
    case friendly = "Friendly"
    case sarcastic = "Sarcastic"
    case sporty = "Sporty"
    
    var icon: ImageResource {
        switch self {
            case .friendly:
                    .Images.Character.friendly
            case .sarcastic:
                    .Images.Character.sarcastic
            case .sporty:
                    .Images.Character.sporty
        }
    }
    
    mutating func back() {
        switch self {
            case .friendly:
                self = .sporty
            case .sarcastic:
                self = .friendly
            case .sporty:
                self = .sarcastic
        }
    }
    
    mutating func next() {
        switch self {
            case .friendly:
                self = .sarcastic
            case .sarcastic:
                self = .sporty
            case .sporty:
                self = .friendly
        }
    }
}
