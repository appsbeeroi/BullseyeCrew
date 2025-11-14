import Foundation

protocol DataCodingServicing {
    func encode<T: Codable>(_ object: T) throws -> Data
    func decode<T: Codable>(_ type: T.Type, from data: Data) throws -> T
}
