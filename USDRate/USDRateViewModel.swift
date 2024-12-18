import SwiftUI

class USDRateViewModel: ObservableObject {
    @Published var rate: Float? = nil
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    func getUSDRUB(from rubles: String, rate: Float) -> String {
        var value: Float = 0
        do {
            value = try Float(rubles, format: .number)
            value *= rate
        } catch {
            print("\(error)")
        }
        return value.decimals(1)
    }
    
    func updateRate() {
        isLoading = true
        errorMessage = nil
        
        let urlString = "https://www.cbr-xml-daily.ru/daily_json.js"
        
        APIService.shared.fetchRate(from: urlString) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let value):
                    self?.rate = value
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}



