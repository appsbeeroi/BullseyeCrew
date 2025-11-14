import UIKit

enum AppPage: String, Identifiable, CaseIterable {
    
    case players
    case scoring
    case settings
    
    var icon: ImageResource {
        switch self {
            case .players:
                    .Images.Icons.TabBar.players
            case .scoring:
                    .Images.Icons.TabBar.scoring
            case .settings:
                    .Images.Icons.TabBar.settings
        }
    }
    
    var id: Self {
        self
    }
}
