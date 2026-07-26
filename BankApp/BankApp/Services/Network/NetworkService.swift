import Foundation

struct EmptyResponse: Decodable {}

class NetworkService: NetworkServiceProtocol {
    func makeRequest<T: Decodable>(url: URL, method: HttpMethod, headers: [String: String]? = nil, body: Data? = nil, responseType: T.Type? = nil, completion: @escaping (Result<Any, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let headers = headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        request.httpBody = body
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            let statusCode = httpResponse.statusCode
            if !(200...299).contains(statusCode) {
                completion(.failure(NetworkError.serverError(statusCode)))
                return
            }
            
            guard let data = data else {
                if responseType != nil {
                    completion(.failure(NetworkError.noData))
                } else {
                    completion(.success(Data() as Any))
                }
                return
            }
            
            if let responseType = responseType {
                do {
                    let decodedObject = try JSONDecoder().decode(responseType, from: data)
                    completion(.success(decodedObject))
                } catch {
                    completion(.failure(NetworkError.decodingError))
                }
            } else {
                completion(.success(data))
            }
        }
        
        task.resume()
    }
}
