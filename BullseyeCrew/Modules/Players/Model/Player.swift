import UIKit

struct Player: Identifiable, Hashable {
    let id: UUID
    var type: PlayerType?
    var avatar: UIImage?
    var name: String
    var scoreData: ScoreData?
    
    var isReadyToSave: Bool {
        type != nil && avatar != nil && name != ""
    }
    
    init(isStumb: Bool) {
        self.id = UUID()
        self.type = isStumb ? .single : nil
        self.avatar = isStumb ? UIImage(resource: .Images.Players.single) : nil
        self.name = isStumb ? "Player 1" : ""
        self.scoreData = ScoreData(isStumb: isStumb)
    }
    
    init(from defaults: PlayerDefault, and image: UIImage) {
        self.id = defaults.id
        self.type = defaults.type
        self.avatar = image
        self.name = defaults.name
        self.scoreData = defaults.scoreData
    }
}
