import Foundation

class DataStorageFacade: DataStorageProtocol {
    private var users: [String: User] = [:]
    
    func getUser(email: String, completion: @escaping (Result<User?, Error>) -> Void) {
        let user = users[email]
        completion(.success(user))
    }
    
    func saveUser(user: User, completion: @escaping (Result<Bool, Error>) -> Void) {
        users[user.email] = user
        completion(.success(true))
    }
}
