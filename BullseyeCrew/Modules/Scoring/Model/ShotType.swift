import UIKit

enum ShotType: String, CaseIterable, Identifiable, Codable {
    case bow = "Bow"
    case crossbow = "Crossbow"
    
    var icon: ImageResource {
        switch self {
            case .bow:
                    .Images.Scoring.bow
            case .crossbow:
                    .Images.Scoring.crossbow
        }
    }
    
    var id: Self {
        self
    }
}
