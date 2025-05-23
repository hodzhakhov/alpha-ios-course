import Foundation

class AuthService: AuthServiceProtocol {
    private let dataStorage: DataStorageProtocol
    
    init(dataStorage: DataStorageProtocol) {
        self.dataStorage = dataStorage
    }
    
    func login(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        dataStorage.getUser(email: email) { result in
            switch result {
            case .success(let user):
                if let user = user {
                    if user.password == password {
                        completion(.success(user))
                    } else {
                        completion(.failure(AuthError.invalidCredentials))
                    }
                } else {
                    completion(.failure(AuthError.userNotFound))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func register(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        dataStorage.getUser(email: email) { [weak self] result in
            switch result {
            case .success(let existingUser):
                if existingUser != nil {
                    completion(.failure(AuthError.userAlreadyExists))
                } else {
                    let newUser = User(id: UUID().uuidString, email: email, password: password)
                    self?.dataStorage.saveUser(user: newUser) { saveResult in
                        switch saveResult {
                        case .success:
                            completion(.success(newUser))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
} 
