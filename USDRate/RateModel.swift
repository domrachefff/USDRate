import Foundation

struct Rates: Codable {
    var Valute: USDRates
    
    struct USDRates: Codable {
        var USD: USDDesc
    }
    struct USDDesc: Codable {
        var Value: Float
    }
}
