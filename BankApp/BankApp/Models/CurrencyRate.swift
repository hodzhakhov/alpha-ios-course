import Foundation

struct CurrencyRate: Codable {
    let currency: String
    let rate: Double
}

struct CurrencyResponse: Codable {
    let base: String
    let timestamp: Int
    let rates: [String: Double]
}
