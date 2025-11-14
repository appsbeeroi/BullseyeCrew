import Foundation

final class StorageService: StorageServicing {
    
    static let shared = StorageService()
    
    private let userDefaults: UserDefaults
    private let coder: DataCodingServicing
    
    private init(
        userDefaults: UserDefaults = .standard,
        coder: DataCodingServicing = DataCodingService()
    ) {
        self.userDefaults = userDefaults
        self.coder = coder
    }
    
    func save<T: Codable>(_ value: T, for key: StorageKey) async {
        do {
            let data = try coder.encode(value)
            userDefaults.set(data, forKey: key.rawValue)
        } catch {
            debugPrint("⚠️ Failed to encode \(T.self): \(error.localizedDescription)")
        }
    }
    
    func load<T: Codable>(_ type: T.Type, for key: StorageKey) async -> T? {
        guard let data = userDefaults.data(forKey: key.rawValue) else {
            return nil
        }
        do {
            return try coder.decode(T.self, from: data)
        } catch {
            debugPrint("⚠️ Failed to decode \(T.self): \(error.localizedDescription)")
            return nil
        }
    }
    
    func removeValue(for key: StorageKey) async {
        userDefaults.removeObject(forKey: key.rawValue)
    }
}
