import UIKit

class FeaturesViewController: UIViewController, FeaturesViewProtocol {
    var presenter: FeaturesPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.fetchFeatures()
        presenter?.fetchCurrencyRates()
    }
    
    func displayFeatures(_ features: [Feature]) {
        print(features)
    }
    
    func displayCurrencyRates(_ rates: [CurrencyRate]) {
        print(rates)
    }
    
    func showLoading(_ isLoading: Bool) {
        print("Loading - \(isLoading)")
    }
    
    func showError(_ message: String) {
        print(message)
    }
}
