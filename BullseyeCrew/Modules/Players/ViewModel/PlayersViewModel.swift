import Foundation
import Combine

final class PlayersViewModel: ObservableObject {
    
    private let storageService = StorageService.shared
    private let imageVault = ImageVault.shared
    
    @Published var navigationPath: [PlayerScreens] = []
    
    @Published private(set) var players: [Player] = []
    
    func fetchPlayers() {
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
    
    func save(_ player: Player) {
        Task { [weak self] in
            guard let self,
                  let image = player.avatar else { return }
            
            await self.imageVault.save(image, id: player.id)
            
            var defaults = await self.storageService.load([PlayerDefault].self, for: .player) ?? []
            let newDefault = PlayerDefault(from: player)
            
            if let index = defaults.firstIndex(where: { $0.id == player.id }) {
                defaults[index] = newDefault
            } else {
                defaults.append(newDefault)
            }
            
            await self.storageService.save(defaults, for: .player)
            
            await MainActor.run {
                self.navigationPath.removeAll()
            }
        }
    }
    
    func remove(_ player: Player) {
        Task { [weak self] in
            guard let self else { return }
                        
            var defaults = await self.storageService.load([PlayerDefault].self, for: .player) ?? []
            
            if let index = defaults.firstIndex(where: { $0.id == player.id }) {
                defaults.remove(at: index)
            }
            
            await self.storageService.save(defaults, for: .player)
            
            await MainActor.run {
                self.navigationPath.removeAll()
            }
        }
    }
}
