protocol FeaturesViewProtocol: AnyObject {
    func displayFeatures(_ features: [Feature])
    func displayCurrencyRates(_ rates: [CurrencyRate])
    func showError(_ message: String)
}
