import Foundation

enum AuthError: LocalizedError {
    case invalidEmail
    case invalidPassword
    case userAlreadyExists
    case invalidCredentials
    case userNotFound
    case invalidResponse
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .invalidEmail: return "Введите корректный email"
        case .invalidPassword: return "Пароль должен быть минимум 6 символов"
        case .userAlreadyExists: return "Пользователь уже существует"
        case .invalidCredentials: return "Неверный email или пароль"
        case .userNotFound: return "Пользователь не найден"
        case .invalidResponse: return "Неверный формат ответа"
        case .unknown: return "Ошибка авторизации"
        }
    }
}
