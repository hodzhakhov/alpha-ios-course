class FeaturesInteractor: FeaturesInteractorProtocol {
    private let currencyService: CurrencyServiceProtocol
    private let user: User
    
    init(currencyService: CurrencyServiceProtocol, user: User) {
        self.currencyService = currencyService
        self.user = user
    }

    func fetchFeatures(completion: @escaping (Result<[Feature], Error>) -> Void) {
        let features = [
            Feature(id: "счета", title: "счета", description: "Управление счетами"),
            Feature(id: "переводы", title: "переводы", description: "Перевод средств"),
            Feature(id: "история", title: "история", description: "Просмотр транзакций")
        ]
        completion(.success(features))
    }

    func fetchCurrencyRates(completion: @escaping (Result<[CurrencyRate], Error>) -> Void) {
        currencyService.fetchRates(completion: completion)
    }
}

