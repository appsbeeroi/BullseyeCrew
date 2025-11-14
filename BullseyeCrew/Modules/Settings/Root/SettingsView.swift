import SwiftUI

struct SettingsView: View {
    
    @AppStorage("isPushOn") var isPushOn = false
    
    @Binding var navBarSeen: Bool
    
    @State private var isShowCharacterView = false
    @State private var isOn = false
    @State private var isShowHistoryAlert = false
    @State private var isShowWeb = false
    @State private var isShowPushAlert = false
    
    var body: some View {
        ZStack {
            Image(.Images.BG.mainBG)
                .adoptImage()
            
            VStack {
                navigation
                controls
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top, 20)
            .padding(.horizontal, 30)
            #warning("ссылка")
            if isShowWeb,
               let url = URL(string: "https://www.apple.com") {
                WebView(url: url) {
                    isShowWeb = false
                    navBarSeen = true
                }
                .ignoresSafeArea(edges: [.bottom])
            }
        }
        .onAppear {
            isOn = isPushOn
            
            Task {
                await PushPermissionService.instance.askForPermission()
            }
        }
        .fullScreenCover(isPresented: $isShowCharacterView) {
            CharacterView()
        }
        .alert("Are you sure you want to delete all the data?", isPresented: $isShowHistoryAlert) {
            Button("Yes", role: .destructive) {
                Task {
                    await StorageService.shared.removeValue(for: .player)
                }
            }
        }
        .alert("The push notification wasn't allowed. Open settings?", isPresented: $isShowPushAlert) {
            Button("Yes") {
                openSettings()
            }
            
            Button("No") {
                isOn = false
            }
        }
        .onChange(of: isOn) { isOn in
            switch isOn {
                case true:
                    Task {
                        switch await PushPermissionService.instance.status {
                            case .granted:
                                isPushOn = true
                            case .rejected, .unknown:
                                isShowPushAlert.toggle()
                        }
                    }
                case false:
                    isPushOn = false
            }
        }
    }
    
    private var navigation: some View {
        StrokedTextView(text: "Settings", size: 40)
            .multilineTextAlignment(.center)
    }
    
    private var controls: some View {
        VStack(spacing: 16) {
            ForEach(ControlTypes.allCases) { type in
                Button {
                    switch type {
                        case .notification:
                            return
                        case .character:
                            isShowCharacterView.toggle()
                        case .history:
                            isShowHistoryAlert.toggle()
                        case .aboutTheApp:
                            navBarSeen = false
                            isShowWeb.toggle()
                    }
                } label: {
                    HStack {
                        Text(type.title)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.russo(size: 25))
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.leading)
                        
                        switch type {
                            case .aboutTheApp, .character:
                                Image(.Images.Icons.Buttons.forward)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 38, height: 38)
                            case .notification:
                                Toggle("", isOn: $isOn)
                                    .labelsHidden()
                                    .tint(.bcYellow)
                            case .history:
                                Image(.Images.Icons.Buttons.remove)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 38, height: 38)
                        }
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal, 16)
                    .frame(minHeight: 75)
                    .background(.bcGreen.opacity(0.9))
                    .cornerRadius(20)
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.bcGreen, lineWidth: 3)
                    }
                }
            }
        }
    }
    
    private func openSettings() {
            guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
            if UIApplication.shared.canOpenURL(settingsURL) {
                UIApplication.shared.open(settingsURL)
            }
        }
}

#Preview {
    SettingsView(navBarSeen: .constant(false))
}


