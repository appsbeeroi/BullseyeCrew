import SwiftUI

struct PlayersView: View {
    
    @StateObject var viewModel = PlayersViewModel()
    
    @Binding var navBarSeen: Bool
    
    var body: some View {
        NavigationStack(path: $viewModel.navigationPath) {
            ZStack {
                Image(.Images.BG.mainBG)
                    .adoptImage()
                
                VStack {
                    navigation
                    
                    if viewModel.players.isEmpty {
                        stumb
                    } else {
                        VStack(spacing: 16) {
                            players
                            addButton
                        }
                        .padding(.bottom, 110)
                    }
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(.top, 20)
                .padding(.horizontal, 30)
            }
            .navigationDestination(for: PlayerScreens.self) { screen in
                switch screen {
                    case .addPlayer(let player):
                        AddPlayerView(player: player)
                    case .addType(let player):
                        AddPlayerTypeView(player: player)
                    case .detail(let player):
                        PlayerDetailView(player: player)
                }
            }
            .onAppear {
                navBarSeen = true
                viewModel.fetchPlayers()
            }
        }
        .environmentObject(viewModel)
    }
    
    private var navigation: some View {
        StrokedTextView(text: "Players\nand teams", size: 40)
            .multilineTextAlignment(.center)
    }
    
    private var stumb: some View {
        VStack(spacing: 16) {
            VStack(spacing: 12) {
                Text("Your players will appear here!")
                    .font(.russo(size: 30))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                
                Text("After adding players, you can select the game mode and shooting order")
                    .font(.russo(size: 16))
                    .foregroundStyle(.white.opacity(0.5))
                    .multilineTextAlignment(.center)
            }
            
            addButton
        }
        .padding(.vertical, 27)
        .frame(maxWidth: .infinity)
        .background(.bcGreen.opacity(0.95))
        .cornerRadius(23)
        .overlay {
            RoundedRectangle(cornerRadius: 23)
                .stroke(.bcGreen, lineWidth: 3)
        }
        .frame(maxHeight: .infinity)
        .padding(.bottom, 120)
    }
    
    private var addButton: some View {
        Button {
            navBarSeen = false
            viewModel.navigationPath.append(.addType(Player(isStumb: false)))
        } label: {
            Image(.Images.Icons.Buttons.foundation)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 90)
                .overlay {
                    StrokedTextView(text: "Add", size: 35)
                }
        }
    }
    
    private var players: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(
                columns: [
                    GridItem(spacing: 10),
                    GridItem(spacing: 10)
                ],
                spacing: 10) {
                    ForEach(viewModel.players) { player in
                        Button {
                            navBarSeen = false
                            viewModel.navigationPath.append(.detail(player))
                        } label: {
                            VStack(spacing: 10) {
                                if let image = player.avatar {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 80, height: 80)
                                        .clipped()
                                        .cornerRadius(25)
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(.bcGreen.opacity(0.5), lineWidth: 5)
                                        }
                                }
                                
                                Text(player.name)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.russo(size: 25))
                                    .foregroundStyle(.white)
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.8)
                                
                                HStack {
                                    if let type = player.type {
                                        Image(type.image)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 30, height: 30)
                                        
                                        Text(type.rawValue)
                                            .font(.russo(size: 11))
                                            .foregroundStyle(.white)
                                    }
                                }
                                .frame(height: 38)
                                .padding(.horizontal)
                                .background(.bcGreen.opacity(0.9))
                                .cornerRadius(11)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 11)
                                        .stroke(.bcGreen, lineWidth: 3)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 10)
                            .background(.bcGreen.opacity(0.9))
                            .cornerRadius(25)
                            .overlay {
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(.bcGreen, lineWidth: 4)
                            }
                        }
                    }
                }
                .padding(.top, 5)
        }
        .padding(.bottom, UIScreen.isSE ? 0 : 110)
    }
}

#Preview {
    PlayersView(navBarSeen: .constant(false))
}


extension UIScreen {
    static var isSE: Bool {
        main.bounds.height < 700
    }
}
