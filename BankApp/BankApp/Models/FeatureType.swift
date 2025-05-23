enum FeatureType: String {
    case accounts = "счета"
    case transfers = "переводы"
    case history = "история"
    
    var title: String {
        return rawValue
    }
    
    var description: String {
        switch self {
        case .accounts:
            return "Управление счетами"
        case .transfers:
            return "Перевод средств"
        case .history:
            return "Просмотр транзакций"
        }
    }
}
