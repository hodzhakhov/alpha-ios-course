import Foundation

class FeaturesPresenter: FeaturesPresenterProtocol {
    weak var view: FeaturesViewProtocol?
    var interactor: FeaturesInteractorProtocol?
    var router: FeaturesRouterProtocol?
    private let user: User

    init(user: User) {
        self.user = user
    }
    
    func fetchFeatures() {
        interactor?.fetchFeatures { [weak self] result in
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
        view?.showLoading(true)

        interactor?.fetchCurrencyRates { [weak self] result in
            DispatchQueue.main.async {
                self?.view?.showLoading(false)

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
        switch feature.id {
        case "accounts":
            router?.navigateToAccounts()
        case "transfer":
            router?.navigateToTransfer()
        case "history":
            router?.navigateToTransactionHistory()
        default:
            break
        }
    }
}

