import Foundation

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol NetworkServiceProtocol {
    func makeRequest<T: Decodable>(url: URL, method: HttpMethod, headers: [String: String]?, body: Data?, responseType: T.Type?, completion: @escaping (Result<Any, Error>) -> Void)
}
