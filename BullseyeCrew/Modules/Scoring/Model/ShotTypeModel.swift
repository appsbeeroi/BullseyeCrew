import Foundation

struct ShotTypeModel: Identifiable, Codable, Hashable {
    let id: UUID
    var shotType: ShotType?
    var score: String
    
    var isSaveable: Bool {
        shotType != nil && score != ""
    }
    
    init(isStumb: Bool) {
        self.id = UUID()
        self.shotType = isStumb ? .bow : nil
        self.score = isStumb ? "3": ""
    }
}
