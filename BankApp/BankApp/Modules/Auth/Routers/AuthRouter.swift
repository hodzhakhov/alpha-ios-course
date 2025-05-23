import UIKit

class AuthRouter: AuthRouterProtocol {
    weak var viewController: UIViewController?
    
    func navigateToFeaturesScreen(user: User) {
        print("Успешная авторизация. Пользователь: \(user.email)")
        
        // let featuresViewController = FeaturesModuleBuilder.build(user: user)
        //
        // под "эти должен заниматься роутер" имелось ввиду следующее?
        
        let view = FeaturesViewController()
        let networkService = NetworkService()
        let currencyService = CurrencyService(networkService: networkService)
        let interactor = FeaturesInteractor(currencyService: currencyService, user: user)
        let router = FeaturesRouter()
        let presenter = FeaturesPresenter(view: view, interactor: interactor, router: router, user: user)
        
        view.presenter = presenter
        router.viewController = view
        
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
}
