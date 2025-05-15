protocol AuthViewProtocol: AnyObject {
    func showLoginScreen()
    func showRegistrationScreen()
    func showLoading(_ isLoading: Bool)
    func showError(_ message: String)
    func setAuthButtonEnabled(_ enabled: Bool)
}
