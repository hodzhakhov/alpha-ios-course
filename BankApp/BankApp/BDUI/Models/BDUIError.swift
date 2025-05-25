import Foundation

enum BDUIError: Error {
    case invalidComponentType
    case invalidActionType
    case invalidContent
    case mappingError
    
    var localizedDescription: String {
        switch self {
        case .invalidComponentType:
            return "Неверный тип компонента"
        case .invalidActionType:
            return "Неверный тип действия"
        case .invalidContent:
            return "Неверный контент"
        case .mappingError:
            return "Ошибка маппинга"
        }
    }
}
