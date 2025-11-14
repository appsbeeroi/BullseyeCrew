import SwiftUI

struct ScoringView: View {
    
    @StateObject private var viewModel = ScoringViewModel()
    
    @Binding var navBarSeen: Bool
    
    var scores: [ScoreData] {
        viewModel.players.compactMap { $0.scoreData }
    }
    
    @State private var isShowShots = false
    
    var body: some View {
        NavigationStack(path: $viewModel.navigationPath) {
            ZStack {
                Image(.Images.BG.mainBG)
                    .adoptImage()
                
                VStack {
                    navigation
                    
                    if scores.isEmpty {
                        stumb
                    } else {
                        VStack(spacing: 32) {
                            ScrollView(showsIndicators: false) {
                                VStack(spacing: 32) {
                                    players
                                    shots
                                }
                                .padding(.horizontal, 2)
                            }
                            
                            addButton
                        }
                        .padding(.bottom, 110)
                    }
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(.top, 20)
                .padding(.horizontal, 30)
            }
            .navigationDestination(for: ScoringScreen.self) { screen in
                switch screen {
                    case .addPlayer(let score):
                        AddScorePlayerView(score: score)
                    case .addScore(let score):
                        AddScoreView(scoreData: score)
                    case .detail(let player):
                        ScoreDetailView(player: player)
                }
            }
            .onAppear {
                navBarSeen = true
                viewModel.fetch()
            }
        }
        .environmentObject(viewModel)
    }
    
    private var navigation: some View {
        StrokedTextView(text: "Scoring\nSystem", size: 40)
            .multilineTextAlignment(.center)
    }
    
    private var stumb: some View {
        VStack(spacing: 16) {
            VStack(spacing: 12) {
                Text("Results haven’t been counted yet")
                    .font(.russo(size: 30))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                
                Text("After the first shot, scores and the leaderboard will appear here")
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
            viewModel.navigationPath.append(.addPlayer(ScoreData(isStumb: false)))
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
        LazyVStack(spacing: 10) {
            ForEach(Array(viewModel.players.enumerated()), id: \.offset) { index, player in
                Button {
                    navBarSeen = false
                    viewModel.navigationPath.append(.detail(player))
                } label: {
                    HStack(spacing: 6) {
                        Text((index + 1).formatted())
                            .font(.russo(size: 35))
                            .foregroundStyle(.white)
                        
                        VStack(spacing: 8) {
                            if let image = player.avatar {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 70, height: 70)
                                    .clipped()
                                    .cornerRadius(20)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(.bcGreen.opacity(0.5), lineWidth: 5)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            
                            Text(player.name)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.russo(size: 22))
                                .foregroundStyle(.white)
                        }
                        
                        VStack {
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
                            .padding(.horizontal, 10)
                            .cornerRadius(15)
                            .overlay {
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(.bcGreen, lineWidth: 1)
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            
                            Spacer()
                            
                            HStack {
                                VStack {
                                    Text("Total score")
                                        .font(.russo(size: 12))
                                        .foregroundStyle(.white.opacity(0.5))
                                    
                                    if let scoreData = player.scoreData {
                                        Text(scoreData.totalScore)
                                            .font(.russo(size: 20))
                                            .foregroundStyle(.white)
                                    }
                                }
                                .padding(6)
                                .cornerRadius(15)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(.bcGreen, lineWidth: 1)
                                }
                                
                                VStack {
                                    Text("Average")
                                        .font(.russo(size: 12))
                                        .foregroundStyle(.white.opacity(0.5))
                                    
                                    if let scoreData = player.scoreData {
                                        Text(scoreData.average)
                                            .font(.russo(size: 20))
                                            .foregroundStyle(.white)
                                    }
                                }
                                .padding(6)
                                .cornerRadius(15)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(.bcGreen, lineWidth: 1)
                                }
                            }
                            .fixedSize(horizontal: true, vertical: false)
                        }
                    }
                    .frame(height: 113)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 10)
                    .background(.bcLightGreen)
                    .cornerRadius(20)
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.bcGreen, lineWidth: 4)
                    }
                }
            }
        }
        .padding(10)
        .background(.bcGreen.opacity(0.9))
        .cornerRadius(30)
        .overlay {
            RoundedRectangle(cornerRadius: 30)
                .stroke(.bcGreen, lineWidth: 3)
        }
    }
    
    private var shots: some View {
        VStack(spacing: 12) {
            HStack {
                StrokedTextView(text: "Shots", size: 30)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Button {
                    isShowShots.toggle()
                } label: {
                    Text(isShowShots ? "Hide" : "Show all")
                        .frame(height: 38)
                        .padding(.horizontal)
                        .font(.russo(size: 25))
                        .foregroundStyle(.white)
                        .background(.bcLightGreen)
                        .cornerRadius(20)
                }
            }
            
            LazyVStack(spacing: 10) {
                ForEach(viewModel.players) { player in
                    if let scores = player.scoreData?.scores.prefix(isShowShots ? 100 : 3) {
                        ForEach(Array(scores.enumerated()), id: \.offset) { index, score in
                            HStack(spacing: 6) {
                                VStack(spacing: 8) {
                                    if let image = player.avatar {
                                        Image(uiImage: image)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 70, height: 70)
                                            .clipped()
                                            .cornerRadius(20)
                                            .overlay {
                                                RoundedRectangle(cornerRadius: 20)
                                                    .stroke(.bcGreen.opacity(0.5), lineWidth: 5)
                                            }
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                    
                                    Text(player.name)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .font(.russo(size: 22))
                                        .foregroundStyle(.white)
                                }
                                
                                VStack {
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
                                    .padding(.horizontal, 10)
                                    .cornerRadius(15)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 15)
                                            .stroke(.bcGreen, lineWidth: 1)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    
                                    Spacer()
                                    
                                    HStack {
                                        VStack {
                                            Text("Round")
                                                .font(.russo(size: 12))
                                                .foregroundStyle(.white.opacity(0.5))
                                            
                                            Text((index + 1).formatted())
                                                .font(.russo(size: 20))
                                                .foregroundStyle(.white)
                                        }
                                        .padding(6)
                                        .cornerRadius(15)
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 15)
                                                .stroke(.bcGreen, lineWidth: 1)
                                        }
                                        
                                        VStack {
                                            Text("Score")
                                                .font(.russo(size: 12))
                                                .foregroundStyle(.white.opacity(0.5))
                                            
                                            Text(score.score)
                                                .font(.russo(size: 20))
                                                .foregroundStyle(.white)
                                        }
                                        .padding(6)
                                        .cornerRadius(15)
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 15)
                                                .stroke(.bcGreen, lineWidth: 1)
                                        }
                                    }
                                    .fixedSize(horizontal: true, vertical: false)
                                }
                            }
                            .frame(height: 113)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 10)
                            .background(.bcLightGreen)
                            .cornerRadius(20)
                            .overlay {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(.bcGreen, lineWidth: 4)
                            }

                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ScoringView(navBarSeen: .constant(false))
}
