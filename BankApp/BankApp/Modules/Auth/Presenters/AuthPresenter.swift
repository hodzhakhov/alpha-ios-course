import Foundation

class AuthPresenter: AuthPresenterProtocol {
    weak var view: AuthViewProtocol?
    let interactor: AuthInteractorProtocol
    let router: AuthRouterProtocol
    
    init(view: AuthViewProtocol, interactor: AuthInteractorProtocol, router: AuthRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
        updateViewMode()
    }
    
    private var isLoginMode: Bool = true {
        didSet {
            updateViewMode()
        }
    }
    
    private func updateViewMode() {
        if isLoginMode {
            view?.showLoginScreen()
        } else {
            view?.showRegistrationScreen()
        }
    }
    
    func authButtonTapped(email: String, password: String, confirmPassword: String?) {
        if isLoginMode {
            loginButtonTapped(email: email, password: password)
        } else {
            guard let confirmPassword = confirmPassword else { return }
            registerButtonTapped(email: email, password: password, confirmPassword: confirmPassword)
        }
    }
    
    func toggleAuthMode() {
        isLoginMode.toggle()
    }
    
    func loginButtonTapped(email: String, password: String) {
        view?.showLoading(true)
        interactor.login(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                self?.view?.showLoading(false)
                switch result {
                case .success(let user):
                    self?.router.navigateToFeaturesScreen(user: user)
                case .failure(let error):
                    self?.view?.showError(error.localizedDescription)
                }
            }
        }
    }
    
    func registerButtonTapped(email: String, password: String, confirmPassword: String) {
        view?.showLoading(true)
        interactor.register(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                self?.view?.showLoading(false)
                switch result {
                case .success(let user):
                    self?.router.navigateToFeaturesScreen(user: user)
                case .failure(let error):
                    self?.view?.showError(error.localizedDescription)
                }
            }
        }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return predicate.evaluate(with: email)
    }
    
    func validateInput(email: String, password: String, confirmPassword: String?) {
        guard !email.isEmpty else {
            view?.showError("Email не может быть пустым")
            view?.setAuthButtonEnabled(false)
            return
        }
        
        guard isValidEmail(email) else {
            view?.showError("Невалидный email")
            view?.setAuthButtonEnabled(false)
            return
        }
        
        guard password.count >= 6 else {
            view?.showError("Пароль должен быть от 6 символов")
            view?.setAuthButtonEnabled(false)
            return
        }
        
        if let confirm = confirmPassword {
            guard password == confirm else {
                view?.showError("Пароли не совпадают")
                view?.setAuthButtonEnabled(false)
                return
            }
        }
        
        view?.showError("")
        view?.setAuthButtonEnabled(true)
    }
}
