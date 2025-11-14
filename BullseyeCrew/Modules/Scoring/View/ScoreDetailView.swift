import SwiftUI

struct ScoreDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var viewModel: ScoringViewModel
    
    var player: Player
    
    @State private var isShowAlert = false
    
    var body: some View {
        ZStack {
            Image(.Images.BG.mainBG)
                .adoptImage()
            
            VStack {
                navigation
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 36) {
                        VStack(spacing: 16) {
                            HStack(spacing: 8) {
                                if let avatar = player.avatar {
                                    Image(uiImage: avatar)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 70, height: 80)
                                        .clipped()
                                        .cornerRadius(25)
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 25)
                                                .stroke(.bcGreen.opacity(0.5), lineWidth: 5)
                                        }
                                }
                                
                                HStack {
                                    if let type = player.type {
                                        Image(type.image)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 50, height: 30)
                                        
                                        Text(type.rawValue)
                                            .font(.russo(size: 14))
                                            .foregroundStyle(.white)
                                    }
                                }
                                .frame(height: 58)
                                .padding(.horizontal)
                                .background(.bcGreen.opacity(0.9))
                                .cornerRadius(20)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(.bcGreen, lineWidth: 3)
                                }
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                            }
                            
                            VStack {
                                Text("Team name")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.russo(size: 18))
                                    .foregroundStyle(.white.opacity(0.5))
                                
                                Text(player.name)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.russo(size: 25))
                                    .foregroundStyle(.white)
                            }
                            
                            VStack {
                                Text("Shooting Order")
                                    .font(.russo(size: 18))
                                    .foregroundStyle(.white.opacity(0.5))
                                
                                let order = player.scoreData?.scores.count ?? 0
                                
                                Text(order.formatted())
                                    .font(.russo(size: 30))
                                    .foregroundStyle(.white)
                            }
                            .padding(.vertical, 14)
                            .padding(.horizontal, 12)
                            .background(.bcGreen.opacity(0.9))
                            .cornerRadius(20)
                            .overlay {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(.bcGreen, lineWidth: 3)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 12)
                        .background(.bcGreen.opacity(0.9))
                        .cornerRadius(20)
                        .overlay {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(.bcGreen, lineWidth: 3)
                        }
                        
                        VStack {
                            Text("Shot")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.russo(size: 25))
                                .foregroundStyle(.white)
                            
                            let source = player.scoreData?.scores ?? []
                            
                            LazyVStack(spacing: 10) {
                                ForEach(Array(source.enumerated()), id: \.offset) { index, score in
                                    HStack {
                                        VStack {
                                            Text(score.shotType?.rawValue ?? "")
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .font(.russo(size: 25))
                                                .foregroundStyle(.white)
                                            
                                            if let image = score.shotType?.icon {
                                                Image(image)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 60, height: 80)
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                            }
                                        }
                                        
                                        HStack {
                                            VStack {
                                                Text("Round")
                                                    .font(.russo(size: 18))
                                                    .foregroundStyle(.white.opacity(0.5))
                                                
                                                Text((index + 1).formatted())
                                                    .font(.russo(size: 30))
                                                    .foregroundStyle(.white)
                                            }
                                            .padding()
                                            .overlay {
                                                RoundedRectangle(cornerRadius: 20)
                                                    .stroke(.bcGreen, lineWidth: 3)
                                            }
                                            
                                            VStack {
                                                Text("Score")
                                                    .font(.russo(size: 18))
                                                    .foregroundStyle(.white.opacity(0.5))
                                                
                                                Text(score.score)
                                                    .font(.russo(size: 30))
                                                    .foregroundStyle(.white)
                                            }
                                            .padding()
                                            .overlay {
                                                RoundedRectangle(cornerRadius: 20)
                                                    .stroke(.bcGreen, lineWidth: 3)
                                            }
                                        }
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                        .fixedSize(horizontal: true, vertical: false)
                                    }
                                    .padding(12)
                                    .background(.bcGreen.opacity(0.9))
                                    .cornerRadius(20)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(.bcGreen, lineWidth: 3)
                                    }
                                }
                            }
                            .padding(.horizontal, 2)
                        }
                    }
                    .padding(.top)
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top, 20)
            .padding(.horizontal, 30)
        }
        .navigationBarBackButtonHidden()
        .alert("You want to delete this one?", isPresented: $isShowAlert) {
            Button("Yes", role: .destructive) {
                guard let scoreData = player.scoreData else { return }
                viewModel.remove(scoreData)
            }
        }
    }
    
    private var navigation: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(.Images.Icons.Buttons.back)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 70)
            }
            
            HStack(spacing: 8) {
                Button {
                    isShowAlert.toggle()
                } label: {
                    Image(.Images.Icons.Buttons.remove)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                }
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}

#Preview {
    ScoreDetailView(player: Player(isStumb: true))
        .environmentObject(ScoringViewModel())
}
