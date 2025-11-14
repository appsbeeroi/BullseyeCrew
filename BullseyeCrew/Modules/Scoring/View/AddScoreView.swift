import SwiftUI

struct AddScoreView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var viewModel: ScoringViewModel
    
    @State var scoreData: ScoreData
    
    @State private var shot = ShotTypeModel(isStumb: false)
    @State private var isShowRobbie = false
    
    @FocusState var isFocused: Bool
    
    var body: some View {
        ZStack {
            Image(.Images.BG.mainBG)
                .adoptImage()
            
            VStack {
                navigation
                
                VStack(spacing: 10) {
                    roundInput
                    shotType
                    score
                }
                .padding(.top)
                .toolbar {
                    ToolbarItem(placement: .keyboard) {
                        Button("Done") {
                            isFocused = false
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top, 20)
            .padding(.horizontal, 30)
            
            if isShowRobbie {
                Color.black
                    .opacity(0.4)
                    .ignoresSafeArea()
                
                VStack {
                    VStack {
                        Button {
                            viewModel.save(scoreData)
                        } label: {
                            Image(systemName: "multiply")
                                .font(.system(size: 40, weight: .medium))
                                .foregroundStyle(.white.opacity(0.5))
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(20)
                        
                        Text("Great shot! Right on target! 🎯 Keep it up!")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 26)
                            .padding(.horizontal, 14)
                            .font(.russo(size: 27))
                            .foregroundStyle(.black)
                            .background(.white)
                            .cornerRadius(20)
                            .padding(.horizontal, 20)
                    }
                    
                    Spacer()
                    
                    Image(.Images.Scoring.robbie)
                        .resizable()
                        .scaledToFit()
                }
                .ignoresSafeArea(edges: [.bottom])
            }
        }
        .navigationBarBackButtonHidden()
        .animation(.easeInOut, value: isShowRobbie)
        .onChange(of: shot.score) { value in
            guard let score = Int(value) else { return }
            guard score <= 10 else {
                shot.score = "10"
                return
            }
        }
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
                    scoreData.scores.append(shot)
                    
                    if let score = Int(shot.score),
                       score > 7 {
                        isShowRobbie.toggle()
                    } else {
                        viewModel.save(scoreData)
                    }
                } label: {
                    Image(.Images.Icons.Buttons.done)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70, height: 70)
                        .opacity(shot.isSaveable ? 1 : 0.7)
                }
                .disabled(!shot.isSaveable )
            }
        }
    }
    
    private var roundInput: some View {
        let targetPlayerScore = viewModel.players.first(where: { $0.id == scoreData.playerID })
        let roundNumber = (targetPlayerScore?.scoreData?.scores.count ?? 0) + 1
        
        return Text("Round: \((roundNumber).formatted())")
            .frame(height: 75)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 12)
            .font(.russo(size: 25))
            .foregroundStyle(.white)
            .background(.bcGreen.opacity(0.9))
            .cornerRadius(20)
            .overlay {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.bcGreen, lineWidth: 3)
            }
    }
    
    private var shotType: some View {
        VStack {
            Text("Shot Type")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.russo(size: 22))
                .foregroundStyle(.white)
            
            HStack {
                Button {
                    shot.shotType = .bow
                } label: {
                    Image(.Images.Scoring.bow)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 90)
                        .frame(maxWidth: .infinity)
                        .clipped()
                        .padding(.vertical)
                        .background(shot.shotType == .bow ? .bcYellow : .bcGreen)
                        .cornerRadius(20)
                        .overlay {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(shot.shotType == .bow ? .bcLightYellow : .bcGreen, lineWidth: 4)
                        }
                }
                
                Button {
                    shot.shotType = .crossbow
                } label: {
                    Image(.Images.Scoring.crossbow)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 90)
                        .frame(maxWidth: .infinity)
                        .clipped()
                        .padding(.vertical)
                        .background(shot.shotType == .crossbow ? .bcYellow : .bcGreen)
                        .cornerRadius(20)
                        .overlay {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(shot.shotType == .crossbow ? .bcLightYellow : .bcGreen, lineWidth: 4)
                        }
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding(16)
        .background(.bcGreen.opacity(0.9))
        .cornerRadius(23)
    }
    
    private var score: some View {
        BullseyeTextField(text: $shot.score, placeholder: "Score", keyboardType: .numberPad, isFocused: $isFocused)
    }
}

#Preview {
    AddScoreView(scoreData: ScoreData(isStumb: true))
        .environmentObject(ScoringViewModel())
}

