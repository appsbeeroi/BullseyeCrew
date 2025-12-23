import SwiftUI

struct SplashScreen: View {
    
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            Image(.Images.BG.splash)
                .adoptImage()
            
            Image(.Images.Splash.image86)
                .resizable()
                .scaledToFit()
                .padding()
                .scaleEffect(isAnimating ? 0.8 : 1)
                .offset(y: isAnimating ? -20 : 20)
                .animation(.easeInOut(duration: 1).repeatForever(), value: isAnimating)
        }
        .onAppear {
            isAnimating = true
        }
    }
}

#Preview {
    SplashScreen()
}
