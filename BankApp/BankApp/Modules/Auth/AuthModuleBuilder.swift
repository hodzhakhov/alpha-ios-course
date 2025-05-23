import UIKit

class AuthModuleBuilder {
    static func build() -> UIViewController {
        let view = AuthViewController()
        let networkService = NetworkService()
        let dataStorage = DataStorageApi(networkService: networkService)
        let authService = AuthService(dataStorage: dataStorage)
        let interactor = AuthInteractor(authService: authService)
        let router = AuthRouter()
        let presenter = AuthPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        router.viewController = view
        
        return view
    }
}
