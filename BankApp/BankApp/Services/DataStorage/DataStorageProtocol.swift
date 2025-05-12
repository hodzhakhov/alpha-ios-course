protocol DataStorageProtocol {
    func login(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void)
    
    func register(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void)
}
