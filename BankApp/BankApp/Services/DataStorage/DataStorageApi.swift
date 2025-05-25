import Foundation

class DataStorageApi: DataStorageProtocol {
    private let baseURL: URL
    private let networkService: NetworkServiceProtocol
    private let authHeader: String
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
        self.baseURL = URL(string: ApiCreds.URL)!
        
        let loginString = "\(ApiCreds.username):\(ApiCreds.password)"
        guard let loginData = loginString.data(using: .utf8) else { 
            fatalError("Не удалось создать данные авторизации") 
        }
        self.authHeader = "Basic \(loginData.base64EncodedString())"
    }
    
    func getUser(email: String, completion: @escaping (Result<User?, Error>) -> Void) {
        let key = "user_details_\(email)"
        let url = baseURL.appendingPathComponent(key)
        
        let headers = ["Authorization": authHeader]
        
        networkService.makeRequest(url: url, method: .get, headers: headers, body: nil, responseType: User.self) { result in
            switch result {
            case .success(let anyObject):
                if let user = anyObject as? User {
                    completion(.success(user))
                } else {
                    completion(.failure(AuthError.invalidResponse))
                }
            case .failure(let error):
                if let networkError = error as? NetworkError, case .serverError(let code) = networkError, code == 404 {
                    completion(.success(nil))
                } else {
                    completion(.failure(error))
                }
            }
        }
    }
    
    func saveUser(user: User, completion: @escaping (Result<Bool, Error>) -> Void) {
        let key = "user_details_\(user.email)"
        let url = baseURL.appendingPathComponent(key)
        
        let headers = [
            "Authorization": authHeader,
            "Content-Type": "application/json; charset=utf-8"
        ]
        
        do {
            let jsonData = try JSONEncoder().encode(user)
            
            networkService.makeRequest(url: url, method: .post, headers: headers, body: jsonData, responseType: EmptyResponse.self) { result in
                switch result {
                case .success:
                    completion(.success(true))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } catch {
            completion(.failure(error))
        }
    }
}
