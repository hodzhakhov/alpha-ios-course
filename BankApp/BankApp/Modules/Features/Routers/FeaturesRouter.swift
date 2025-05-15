import UIKit

class FeaturesRouter: FeaturesRouterProtocol {
    weak var viewController: UIViewController?
    
    func navigateToAccounts() {
        print("Переход в аккаунты")
    }
    
    func navigateToTransfer() {
        print("Переход в трансфер")
    }
    
    func navigateToTransactionHistory() {
        print("Переход в историю транзакций")
    }
    
    func navigateToProfile() {
        print("Перехож в профиль")
    }
    
    
}
