protocol FeaturesInteractorProtocol: AnyObject {
    func fetchFeatures(completion: @escaping (Result<[Feature], Error>) -> Void)
}
