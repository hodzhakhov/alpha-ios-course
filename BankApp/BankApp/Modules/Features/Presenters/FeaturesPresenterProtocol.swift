protocol FeaturesPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didSelectFeature(_ feature: Feature)
    func handleAppMovedToBackground()
    func handleAppMovedToForeground()
}
