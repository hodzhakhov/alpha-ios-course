import UIKit

class FeaturesModuleBuilder {
    static func build(user: User) -> UIViewController {
        let view = FeaturesViewController()
        let networkService = NetworkService()
        let currencyService = CurrencyService(networkService: networkService)
        let interactor = FeaturesInteractor(currencyService: currencyService, user: user)
        let router = FeaturesRouter()
        let presenter = FeaturesPresenter(view: view, interactor: interactor, router: router, user: user)
        
        view.presenter = presenter
        router.viewController = view
        
        return view
    }
}
