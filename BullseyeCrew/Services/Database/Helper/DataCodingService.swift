import Foundation

final class DataCodingService: DataCodingServicing {
    
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder
    
    init(
        encoder: JSONEncoder = .init(),
        decoder: JSONDecoder = .init()
    ) {
        self.encoder = encoder
        self.decoder = decoder
    }
    
    func encode<T: Codable>(_ object: T) throws -> Data {
        try encoder.encode(object)
    }
    
    func decode<T: Codable>(_ type: T.Type, from data: Data) throws -> T {
        try decoder.decode(T.self, from: data)
    }
}
