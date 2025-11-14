protocol StorageServicing {
    func save<T: Codable>(_ value: T, for key: StorageKey) async
    func load<T: Codable>(_ type: T.Type, for key: StorageKey) async -> T?
    func removeValue(for key: StorageKey) async 
}
