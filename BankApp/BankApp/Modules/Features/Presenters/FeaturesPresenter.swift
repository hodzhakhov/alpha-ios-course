import Foundation

class FeaturesPresenter: FeaturesPresenterProtocol {
    weak var view: FeaturesViewProtocol?
    private let interactor: FeaturesInteractorProtocol
    private let router: FeaturesRouterProtocol
    private let user: User
    
    init(view: FeaturesViewProtocol, interactor: FeaturesInteractorProtocol, router: FeaturesRouterProtocol, user: User) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.user = user
    }
    
    func fetchFeatures() {
        interactor.fetchFeatures { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let features):
                    self?.view?.displayFeatures(features)
                case .failure:
                    self?.view?.showError("Не удалось загрузить функции")
                }
            }
        }
    }
    
    func fetchCurrencyRates() {
        
        interactor.fetchCurrencyRates { [weak self] result in
            DispatchQueue.main.async {
                
                switch result {
                case .success(let rates):
                    self?.view?.displayCurrencyRates(rates)
                case .failure:
                    self?.view?.showError("Не удалось загрузить курсы валют")
                }
            }
        }
    }
    
    func didSelectFeature(_ feature: Feature) {
        switch feature.type {
        case .accounts:
            router.navigateToAccounts()
        case .transfers:
            router.navigateToTransfer()
        case .history:
            router.navigateToTransactionHistory()
        }
    }
}

