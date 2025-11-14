import Foundation
import Combine

final class AppTabViewModel: ObservableObject {
    
    @Published var selectedTab: AppPage = .players
    @Published var navBarSeen = true
}
