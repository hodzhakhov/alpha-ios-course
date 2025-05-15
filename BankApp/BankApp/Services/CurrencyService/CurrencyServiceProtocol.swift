protocol CurrencyServiceProtocol {
    func fetchRates(completion: @escaping (Result<[CurrencyRate], Error>) -> Void)
}
