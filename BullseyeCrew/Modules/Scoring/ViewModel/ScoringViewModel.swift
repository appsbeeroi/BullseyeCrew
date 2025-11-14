import Foundation
import Combine

final class ScoringViewModel: ObservableObject {
    
    private let storageService = StorageService.shared
    private let imageVault = ImageVault.shared
     
    @Published var navigationPath: [ScoringScreen] = []
    
    @Published private(set) var players: [Player] = []
    
    func fetch() {
        Task { [weak self] in
            guard let self else { return }
            
            let defaults = await self.storageService.load([PlayerDefault].self, for: .player) ?? []
            
            let players = await withTaskGroup(of: Player?.self) { group in
                for playerDefault in defaults {
                    group.addTask {
                        guard let image = await self.imageVault.image(for: playerDefault.id) else { return nil }
                        let player = Player(from: playerDefault, and: image)
                        
                        return player
                    }
                }
                
                var players: [Player?] = []
                
                for await player in group {
                    players.append(player)
                }
                
                return players.compactMap { $0 }
            }
            
            await MainActor.run {
                self.players = players
            }
        }
    }
    
    func save(_ score: ScoreData) {
        Task { [weak self] in
            guard let self,
                  let playerID = score.playerID else { return }
            
            var defaults = await self.storageService.load([PlayerDefault].self, for: .player) ?? []
            
            if let index = defaults.firstIndex(where: { $0.id == playerID }) {
                if defaults[index].scoreData == nil {
                    defaults[index].scoreData = score
                } else {
                    guard let shot = score.scores.first else { return }
                    defaults[index].scoreData?.scores.append(shot)
                }
            }
            
            await self.storageService.save(defaults, for: .player)
            
            await MainActor.run {
                self.navigationPath.removeAll()
            }
        }
    }
    
    func remove(_ score: ScoreData) {
        Task { [weak self] in
            guard let self,
                  let playerID = score.playerID else { return }
            
            var defaults = await self.storageService.load([PlayerDefault].self, for: .player) ?? []
            
            if let index = defaults.firstIndex(where: { $0.id == playerID }) {
                defaults[index].scoreData = nil
            }
            
            await self.storageService.save(defaults, for: .player)
            
            await MainActor.run {
                self.navigationPath.removeAll()
            }
        }
    }
}
