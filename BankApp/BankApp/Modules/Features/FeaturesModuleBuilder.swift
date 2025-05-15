import UIKit

class FeaturesModuleBuilder {
    static func build(user: User) -> UIViewController {
        let view = FeaturesViewController()
        let currencyService = CurrencyService()
        let interactor = FeaturesInteractor(currencyService: currencyService, user: user)
        let router = FeaturesRouter()
        let presenter = FeaturesPresenter(user: user)
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        router.viewController = view
        
        return view
    }
}
