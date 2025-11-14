import SwiftUI

struct AddScorePlayerView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var viewModel: ScoringViewModel
    
    @State var score: ScoreData
    
    @State private var player: Player?
    
    var body: some View {
        ZStack {
            Image(.Images.BG.mainBG)
                .adoptImage()
            
            VStack {
                navigation
                
                if viewModel.players.isEmpty {
                    stumb
                } else {
                    choosePlayer
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top, 20)
            .padding(.horizontal, 30)
        }
        .navigationBarBackButtonHidden()
    }
    
    private var navigation: some View {
        ZStack {
            StrokedTextView(text: "Add\nData", size: 40)
                .multilineTextAlignment(.center)
            
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(.Images.Icons.Buttons.back)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70, height: 70)
                }
                
                Spacer()
                
                Button {
                    viewModel.navigationPath.append(.addScore(score))
                } label: {
                    Image(.Images.Icons.Buttons.done)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70, height: 70)
                        .opacity(player == nil ? 0.7 : 1)
                }
                .disabled(player == nil)
            }
        }
    }
    
    private var stumb: some View {
        VStack(spacing: 16) {
            VStack(spacing: 12) {
                Text("There is no player yet")
                    .font(.russo(size: 30))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
            }
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
    
    private var choosePlayer: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                StrokedTextView(text: "Choose player", size: 25)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                LazyVGrid(columns: [GridItem(spacing: 10), GridItem(spacing: 10)]) {
                    ForEach(viewModel.players) { player in
                        Button {
                            self.player = player
                            score.playerID = player.id
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
                            .background(player == self.player ? .bcLightYellow : .bcGreen.opacity(0.9))
                            .cornerRadius(25)
                            .overlay {
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(.bcGreen, lineWidth: 4)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 2)
            .padding(.top)
        }
    }
}

#Preview {
    AddScorePlayerView(score: ScoreData(isStumb: false))
        .environmentObject(ScoringViewModel())
}

