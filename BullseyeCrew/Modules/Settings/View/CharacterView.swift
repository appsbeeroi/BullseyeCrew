import SwiftUI

struct CharacterView: View {
    
    @AppStorage("Character") private var character: CharacterStyle = .friendly
    
    @Environment(\.dismiss) var dismiss
    
    @State private var characterStatus: CharacterStyle = .friendly
    
    var body: some View {
        ZStack {
            Image(.Images.BG.mainBG)
                .adoptImage()
            
            VStack {
                navigation
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        status
                        selector
                        
                        Spacer()
                        
                        chooseButton
                    }
                    .padding(.top)
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top, 20)
            .padding(.horizontal, 30)
        }
        .animation(.easeInOut, value: characterStatus)
        .onAppear {
            characterStatus = character
        }
    }
    
    private var navigation: some View {
        ZStack {
            Button {
                dismiss()
            } label: {
                Image(.Images.Icons.Buttons.back)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 70)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            StrokedTextView(text: "Settings", size: 40)
                .multilineTextAlignment(.center)
        }
    }
    
    private var status: some View {
        Text(characterStatus.rawValue)
            .frame(height: 85)
            .padding(.horizontal)
            .font(.russo(size: 40))
            .background(.bcGreen.opacity(0.9))
            .foregroundStyle(.white)
            .cornerRadius(20)
            .overlay {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.bcGreen, lineWidth: 3)
            }
    }
    
    private var selector: some View {
        VStack {
            Image(characterStatus.icon)
                .resizable()
                .scaledToFit()
                .frame(height: 300)
            
            HStack {
                Button {
                    characterStatus.back()
                } label: {
                    Image(.Images.Icons.Buttons.back)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70, height: 70)
                }
                
                Spacer()
             
                Button {
                    characterStatus.next()
                } label: {
                    Image(.Images.Icons.Buttons.forward)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70, height: 70)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.bcGreen.opacity(0.9))
        .cornerRadius(20)
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(.bcGreen, lineWidth: 3)
        }
    }
    
    private var chooseButton: some View {
        Button {
            character = characterStatus
            dismiss()
        } label: {
            Image(.Images.Icons.Buttons.foundation)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 90)
                .overlay {
                    Text("Choose")
                        .font(.russo(size: 35))
                        .foregroundStyle(.white)
                }
        }
    }
}

#Preview {
    CharacterView()
}
