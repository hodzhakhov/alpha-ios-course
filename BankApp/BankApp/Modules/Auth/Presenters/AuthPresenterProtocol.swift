protocol AuthPresenterProtocol: AnyObject {
    func loginButtonTapped(email: String, password: String)
    func registerButtonTapped(email: String, password: String, confirmPassword: String)
    func didSwitchToLogin()
    func didSwitchToRegister()
    func validateInput(email: String, password: String, confirmPassword: String?)
}
