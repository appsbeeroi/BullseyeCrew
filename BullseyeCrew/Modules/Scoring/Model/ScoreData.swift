import Foundation

struct ScoreData: Identifiable, Codable, Hashable {
    let id: UUID
    var playerID: UUID?
    var scores: [ShotTypeModel]
    
    init(isStumb: Bool) {
        self.id = UUID()
        self.scores = isStumb ? [ShotTypeModel(isStumb: true)] : []
    }
    
    var totalScore: String {
        let scoreNumber = scores.compactMap { Int($0.score) }
        let sum = scoreNumber.reduce(0, +)
        
        return sum.formatted()
    }
    
    var average: String {
        guard !scores.isEmpty else { return "0" }
        let scoreNumber = scores.compactMap { Int($0.score) }
        let sum = scoreNumber.reduce(0, +)
        
        return (sum / scores.count).formatted()
    }
}
