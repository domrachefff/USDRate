import Foundation

class APIService {
    static let shared = APIService()
    private init() {}
    
    func fetchRate(from urlString: String, completion: @escaping (Result<Float, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: -2, userInfo: nil)))
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(Rates.self, from: data)
                let value = decodedResponse.Valute.USD.Value
                completion(.success(value))
                
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}

