import SwiftUI

struct AppTabView: View {
    
    @StateObject private var viewModel: AppTabViewModel = .init()
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack {
            TabView(selection: $viewModel.selectedTab) {
                PlayersView(navBarSeen: $viewModel.navBarSeen)
                    .tag(AppPage.players)
                
                ScoringView(navBarSeen: $viewModel.navBarSeen)
                    .tag(AppPage.scoring)
                
                SettingsView(navBarSeen: $viewModel.navBarSeen)
                    .tag(AppPage.settings)
            }
            
            if viewModel.navBarSeen {
                VStack {
                    HStack {
                        ForEach(AppPage.allCases) { page in
                            Button {
                                viewModel.selectedTab = page
                            } label: {
                                Image(page.icon)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 95, height: 95)
                                    .opacity(viewModel.selectedTab == page ? 1 : 0.7)
                            }
                        }
                    }
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .animation(.default, value: viewModel.navBarSeen)
    }
}

#Preview {
    AppTabView()
}


