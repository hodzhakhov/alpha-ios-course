protocol FeaturesViewProtocol: AnyObject {
    func displayFeatures(_ features: [Feature])
    func showLoading(_ isLoading: Bool)
    func showError(_ message: String)
}
