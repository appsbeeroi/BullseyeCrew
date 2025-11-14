import SwiftUI

struct PlayerDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var viewModel: PlayersViewModel
    
    @State var player: Player
    
    @State private var isShowAlert = false
    
    var body: some View {
        ZStack {
            Image(.Images.BG.mainBG)
                .adoptImage()
            
            VStack {
                navigation
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 16) {
                        HStack(spacing: 8) {
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
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        if let avatar = player.avatar {
                            Image(uiImage: avatar)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 130, height: 130)
                                .clipped()
                                .cornerRadius(25)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 25)
                                        .stroke(.bcGreen.opacity(0.5), lineWidth: 5)
                                }
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
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top, 20)
            .padding(.horizontal, 30)
        }
        .navigationBarBackButtonHidden()
        .alert("You want to delete this one?", isPresented: $isShowAlert) {
            Button("Yes", role: .destructive) {
                viewModel.remove(player)
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
                    viewModel.navigationPath.append(.addType(player))
                } label: {
                    Image(.Images.Icons.Buttons.edit)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                }
                
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
    PlayerDetailView(player: Player(isStumb: true))
}
