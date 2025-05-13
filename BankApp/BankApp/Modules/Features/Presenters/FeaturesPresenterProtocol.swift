protocol FeaturesPresenterProtocol: AnyObject {
    func fetchFeatures()
    func fetchCurrencyRates()
    func didSelectFeature(_ feature: Feature)
}
