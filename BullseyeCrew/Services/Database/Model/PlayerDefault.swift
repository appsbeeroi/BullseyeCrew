import Foundation

struct PlayerDefault: Codable {
    let id: UUID
    let type: PlayerType
    let name: String
    var scoreData: ScoreData?
    
    init(from model: Player) {
        self.id = model.id
        self.type = model.type ?? .command
        self.name = model.name
        self.scoreData = model.scoreData
    }
}
