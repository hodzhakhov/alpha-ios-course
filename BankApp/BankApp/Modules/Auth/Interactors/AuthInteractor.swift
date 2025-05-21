import Foundation

class AuthInteractor: AuthInteractorProtocol {
    private let authService: AuthServiceProtocol
    
    init(authService: AuthServiceProtocol) {
        self.authService = authService
    }
    
    func login(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        authService.login(email: email, password: password) { result in
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
        authService.login(email: email, password: password) { [weak self] result in
            switch result {
            case .success:
                completion(.failure(AuthError.userAlreadyExists))
            case .failure:
                self?.authService.register(email: email, password: password, completion: completion)
            }
        }
    }
}
