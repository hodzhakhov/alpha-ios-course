import UIKit

class FeaturesRouter: FeaturesRouterProtocol {
    weak var viewController: UIViewController?
    
    func navigateToAccounts() {
        print("Navigate to Accounts")
    }
    
    func navigateToTransfer() {
        print("Navigate to Transfer")
    }
    
    func navigateToTransactionHistory() {
        print("Navigate to Transaction History")
    }
    
    func navigateToProfile() {
        print("Navigate to Profile")
    }
    
    
}
