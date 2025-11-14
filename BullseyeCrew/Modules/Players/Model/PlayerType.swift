import UIKit

enum PlayerType: String, Identifiable, CaseIterable, Codable {
    case single = "Single"
    case command = "Command"
    
    var id: Self {
        self
    }
    
    var image: ImageResource {
        switch self {
            case .single:
                    .Images.Players.single
            case .command:
                    .Images.Players.team
        }
    }
}
