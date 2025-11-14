enum ControlTypes: Identifiable, CaseIterable {
    case character
    case notification
    case history
    case aboutTheApp
    
    var title: String {
        switch self {
            case .character:
                "Choice of\ncharacter style"
            case .notification:
                "Notification"
            case .history:
                "History"
            case .aboutTheApp:
                "About the App"
        }
    }
    
    var id: Self {
        self
    }
}
