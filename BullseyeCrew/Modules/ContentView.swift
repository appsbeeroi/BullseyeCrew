import SwiftUI

struct ContentView: View {
    
    @State private var shouldTurnMain = false
    
    var body: some View {
        if shouldTurnMain {
            AppTabView()
        } else {
            SplashScreen(shouldTurnMain: $shouldTurnMain)
        }
    }
}

#Preview {
    ContentView()
}
