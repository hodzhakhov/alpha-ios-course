protocol FeaturesInteractorProtocol: AnyObject {
    func fetchFeatures(completion: @escaping (Result<[Feature], Error>) -> Void)
    func fetchCurrencyRates(completion: @escaping (Result<[CurrencyRate], Error>) -> Void)
}
