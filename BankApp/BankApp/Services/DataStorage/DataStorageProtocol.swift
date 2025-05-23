protocol DataStorageProtocol {
    func getUser(email: String, completion: @escaping (Result<User?, Error>) -> Void)
    func saveUser(user: User, completion: @escaping (Result<Bool, Error>) -> Void)
}
