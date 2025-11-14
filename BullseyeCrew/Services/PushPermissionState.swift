import UserNotifications

enum PushPermissionState {
    case granted
    case rejected
    case unknown
}

final class PushPermissionService {
    
    static let instance = PushPermissionService()
    
    private init() {}
    
    var status: PushPermissionState {
        get async {
            let center = UNUserNotificationCenter.current()
            let config = await center.notificationSettings()
            
            switch config.authorizationStatus {
            case .authorized, .provisional:
                return .granted
            case .denied:
                return .rejected
            case .notDetermined:
                return .unknown
            @unknown default:
                return .rejected
            }
        }
    }
    
    @discardableResult
    func askForPermission() async -> Bool {
        let center = UNUserNotificationCenter.current()
        
        do {
            let result = try await center.requestAuthorization(options: [.badge, .sound, .alert])
            return result
        } catch {
            print("⚠️ Error while asking notification permission:", error.localizedDescription)
            return false
        }
    }
}
