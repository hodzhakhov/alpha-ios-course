protocol AuthInteractorProtocol: AnyObject {
    func login(login: String, password: String, completion: @escaping (Result<User, Error>) -> Void)
    func register(login: String, password: String, completion: @escaping (Result<User, Error>) -> Void)
}
