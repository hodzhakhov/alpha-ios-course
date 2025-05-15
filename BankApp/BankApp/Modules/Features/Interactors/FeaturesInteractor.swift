class FeaturesInteractor: FeaturesInteractorProtocol {
    private let currencyService: CurrencyServiceProtocol
    private let user: User
    
    init(currencyService: CurrencyServiceProtocol, user: User) {
        self.currencyService = currencyService
        self.user = user
    }

    func fetchFeatures(completion: @escaping (Result<[Feature], Error>) -> Void) {
        let features = [
            Feature(id: "accounts", title: "Счета", description: "Управление счетами"),
            Feature(id: "transfer", title: "Переводы", description: "Перевод средств"),
            Feature(id: "history", title: "История", description: "Просмотр транзакций")
        ]
        completion(.success(features))
    }

    func fetchCurrencyRates(completion: @escaping (Result<[CurrencyRate], Error>) -> Void) {
        currencyService.fetchRates(completion: completion)
    }
}

