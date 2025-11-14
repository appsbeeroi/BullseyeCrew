import SwiftUI

struct AddPlayerView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var viewModel: PlayersViewModel
    
    @State var player: Player
    
    @State private var isShowImagePicker = false
    
    @FocusState var isFocused: Bool
    
    var body: some View {
        ZStack {
            Image(.Images.BG.mainBG)
                .adoptImage()
            
            VStack {
                navigation
                
                VStack(spacing: 16) {
                    typeLabel
                    avatar
                    name
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top, 20)
            .padding(.horizontal, 30)
        }
        .navigationBarBackButtonHidden()
        .sheet(isPresented: $isShowImagePicker) {
            ImagePicker(selectedImage: $player.avatar)
        }
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
                    viewModel.save(player)
                } label: {
                    Image(.Images.Icons.Buttons.done)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70, height: 70)
                        .opacity(player.isReadyToSave ? 1 : 0.7)
                }
                .disabled(!player.isReadyToSave)
            }
        }
    }
    
    private var typeLabel: some View {
        HStack {
            if let type = player.type {
                Image(type.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 40)
                
                Text(type.rawValue)
                    .font(.russo(size: 14))
                    .foregroundStyle(.white)
            }
        }
        .frame(height: 63)
        .padding(.horizontal, 20)
        .background(.bcGreen.opacity(0.95))
        .cornerRadius(20)
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(.bcGreen, lineWidth: 3)
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    private var avatar: some View {
        Button {
            isShowImagePicker.toggle()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: 140, height: 140)
                    .foregroundStyle(.bcGreen.opacity(0.95))
                    .overlay {
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(.bcGreen, lineWidth: 5)
                    }
                
                if let avatar = player.avatar {
                    Image(uiImage: avatar)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 138, height: 138)
                        .clipped()
                        .cornerRadius(25)
                }
                
                VStack(spacing: 0) {
                    Image(systemName: "camera.shutter.button")
                        .font(.system(size: 70, weight: .medium))
                    
                    Text("Avatar")
                        .font(.russo(size: 25))
                }
                .foregroundStyle(.gray.opacity(0.5))
            }
        }
    }
    
    private var name: some View {
        BullseyeTextField(text: $player.name, placeholder: "Player name", isFocused: $isFocused)
    }
}

#Preview {
    AddPlayerView(player: Player(isStumb: true))
}

#Preview {
    AddPlayerView(player: Player(isStumb: false))
}

