import Foundation

class CurrencyService: CurrencyServiceProtocol {
    private let url: URL
    private let cache = CacheService<[CurrencyRate]>(key: "cached_currency_rates", expiration: 3600)
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
        self.url = URL(string: ApiCreds.currencyURL)!
    }
    
    func fetchRates(completion: @escaping (Result<[CurrencyRate], Error>) -> Void) {
        if let cachedRates = cache.load() {
            print("Load from cache")
            completion(.success(cachedRates))
            return
        }
        
        networkService.makeRequest(url: url, method: .get, headers: nil, body: nil, responseType: CurrencyResponse.self) { result in
            switch result {
            case .success(let anyObject):
                if let response = anyObject as? CurrencyResponse {
                    let rates = response.rates.map { CurrencyRate(currency: $0.key, rate: $0.value) }
                    print("Load into cache")
                    self.cache.save(rates)
                    completion(.success(rates))
                } else {
                    completion(.failure(NetworkError.decodingError))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
