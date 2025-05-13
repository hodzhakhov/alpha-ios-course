import UIKit

class AuthRouter: AuthRouterProtocol {
    weak var viewController: UIViewController?
    
    func navigateToFeaturesScreen(user: User) {
        print("Успешная авторизация. Пользователь: \(user.email)")
        
        let featuresViewController = FeaturesModuleBuilder.build(user: user)
        viewController?.navigationController?.pushViewController(featuresViewController, animated: true)
    }
}
