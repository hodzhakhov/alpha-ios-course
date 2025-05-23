enum NetworkError: Error {
    case invalidResponse
    case noData
    case serverError(Int)
    case decodingError
    
    var errorDescription: String? {
        switch self {
        case .invalidResponse: return "Неверный формат ответа"
        case .noData: return "Нет данных"
        case .serverError(let code): return "Сервер вернул ошибку \(code)"
        case .decodingError: return "Ошибка декодирования"
        }
    }
}
