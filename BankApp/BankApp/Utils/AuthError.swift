import Foundation

enum AuthError: LocalizedError {
    case invalidEmail
    case invalidPassword
    case userAlreadyExists
    case invalidCredentials
    
    var errorDescription: String? {
        switch self {
        case .invalidEmail: return "Введите корректный email"
        case .invalidPassword: return "Пароль должен быть минимум 6 символов"
        case .userAlreadyExists: return "Пользователь уже существует"
        case .invalidCredentials: return "Неверный email или пароль"
        }
    }
}
