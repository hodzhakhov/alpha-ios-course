import Foundation

class CurrencyService: CurrencyServiceProtocol {
    private let url = URL(string: ApiCreds.currencyURL)!
    private let cache = CacheService<[CurrencyRate]>(key: "cached_currency_rates", expiration: 3600)
    
    func fetchRates(completion: @escaping (Result<[CurrencyRate], Error>) -> Void) {
        if let cachedRates = cache.load() {
            print("Load from cache")
            completion(.success(cachedRates))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "NoData", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(CurrencyResponse.self, from: data)
                let rates = decoded.rates.map { CurrencyRate(currency: $0.key, rate: $0.value) }
                print("Load into cache")
                self.cache.save(rates)
                completion(.success(rates))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
