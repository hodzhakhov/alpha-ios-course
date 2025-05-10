protocol AuthViewProtocol: AnyObject {
    func showLoginScreen()
    func showRegistrationScreen()
    func showLoading(_ isLoading: Bool)
    func showErrorMessage(_ message: String)
}
