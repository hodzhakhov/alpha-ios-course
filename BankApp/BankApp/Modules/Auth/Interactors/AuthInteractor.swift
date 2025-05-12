import Foundation

class AuthInteractor: AuthInteractorProtocol {
    private let dataStorage: DataStorageProtocol
    
    init(dataStorage: DataStorageProtocol) {
        self.dataStorage = dataStorage
    }
    
    func login(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        dataStorage.login(email: email, password: password) { result in
            switch result {
            case .success(let user):
                if user.password == password {
                    completion(.success(user))
                } else {
                    completion(.failure(AuthError.invalidCredentials))
                }
            case .failure:
                completion(.failure(AuthError.invalidCredentials))
            }
        }
    }
    
    func register(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        dataStorage.login(email: email, password: password) { [weak self] result in
            switch result {
            case .success:
                completion(.failure(AuthError.userAlreadyExists))
            case .failure:
                self?.dataStorage.register(email: email, password: password, completion: completion)
            }
        }
    }
}
