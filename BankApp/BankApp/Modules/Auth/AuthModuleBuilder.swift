import UIKit

class AuthModuleBuilder {
    static func build() -> UIViewController {
        let view = AuthViewController()
        let dataStorage = DataStorageApi()
        let interactor = AuthInteractor(dataStorage: dataStorage)
        let router = AuthRouter()
        let presenter = AuthPresenter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        router.viewController = view
        
        return view
    }
}
