import SwiftUI

struct AddPlayerTypeView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var viewModel: PlayersViewModel
    
    @State var player: Player
    
    var body: some View {
        ZStack {
            Image(.Images.BG.mainBG)
                .adoptImage()
            
            VStack {
                navigation
                types
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top, 20)
            .padding(.horizontal, 30)
        }
        .navigationBarBackButtonHidden()
    }
    
    private var navigation: some View {
        ZStack {
            StrokedTextView(text: "Add\nmember", size: 40)
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.7)
            
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
                    viewModel.navigationPath.append(.addPlayer(player))
                } label: {
                    Image(.Images.Icons.Buttons.done)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70, height: 70)
                        .opacity(player.type == nil ? 0.7 : 1)
                }
                .disabled(player.type == nil)
            }
        }
    }
    
    private var types: some View {
        VStack(spacing: 10) {
            Text("Mode")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.russo(size: 25))
                .foregroundStyle(.white)
            
            ForEach(PlayerType.allCases) { type in
                Button {
                    player.type = type
                } label: {
                    ZStack {
                        VStack(spacing: 0) {
                            Image(type.image)
                                .resizable()
                                .scaledToFit()
                            
                            Text(type.rawValue)
                                .font(.russo(size: 25))
                                .foregroundStyle(.white)
                        }
                        .padding()
                    }
                    .frame(height: 250)
                    .frame(maxWidth: .infinity)
                    .background(player.type == type ? .bcYellow : .bcGreen.opacity(0.95))
                    .cornerRadius(30)
                    .overlay {
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(player.type == type ? .bcLightYellow : .bcGreen, lineWidth: 4)
                    }
                }
            }
        }
    }
}

#Preview {
    AddPlayerTypeView(player: Player(isStumb: false))
        .environmentObject(PlayersViewModel())
}

