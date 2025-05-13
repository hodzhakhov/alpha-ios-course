protocol FeaturesViewProtocol: AnyObject {
    func displayFeatures(_ features: [Feature])
    func displayCurrencyRates(_ rates: [CurrencyRate])
    func showLoading(_ isLoading: Bool)
    func showError(_ message: String)
}
