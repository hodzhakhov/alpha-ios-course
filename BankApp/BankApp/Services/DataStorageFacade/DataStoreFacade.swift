import Foundation

class DataStoreFacade: DataStoreFacadeProtocol {
    private var users: [String: User] = [:]
    
    func login(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        if let user = users[email] {
            completion(.success(user))
        } else {
            completion(.failure(NSError(domain: "DataStoreFacade", code: 404, userInfo: nil)))
        }
    }
    
    func register(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        let newUser = User(id: UUID().uuidString, email: email, password: password)
        users[email] = newUser
        completion(.success(newUser))
    }
}
