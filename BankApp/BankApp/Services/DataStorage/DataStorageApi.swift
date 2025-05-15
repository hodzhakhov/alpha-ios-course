import Foundation

class DataStorageApi: DataStorageProtocol {
    private let baseURL = URL(string: ApiCreds.URL)!
    private let username = ApiCreds.username
    private let password = ApiCreds.password
    
    private var authHeader: String {
        let loginString = "\(username):\(password)"
        guard let loginData = loginString.data(using: .utf8) else { return "" }
        return "Basic \(loginData.base64EncodedString())"
    }
    
    func login(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        let key = "user_details_\(email)"
        let url = baseURL.appendingPathComponent(key)
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(authHeader, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(AuthError.unknown))
                return
            }
            
            if httpResponse.statusCode == 404 {
                completion(.failure(AuthError.userNotFound))
                return
            }
            
            guard let data = data else {
                completion(.failure(AuthError.invalidResponse))
                return
            }
            
            do {
                let user = try JSONDecoder().decode(User.self, from: data)
                if (user.password == password) {
                    completion(.success(user))
                } else {
                    completion(.failure(AuthError.invalidCredentials))
                }
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func register(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        let key = "user_details_\(email)"
        let url = baseURL.appendingPathComponent(key)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue(authHeader, forHTTPHeaderField: "Authorization")
        
        let user = User(id: UUID().uuidString, email: email, password: password)
        
        do {
            let jsonData = try JSONEncoder().encode(user)
            request.httpBody = jsonData
        } catch {
            completion(.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { _, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            completion(.success(user))
        }
        
        task.resume()
    }
}
