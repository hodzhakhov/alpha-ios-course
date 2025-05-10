protocol AuthPresenterProtocol: AnyObject {
    func loginButtonTapped(login: String, password: String)
    func registerButtonTapped(login: String, password: String, confirmPassword: String)
    func didSwitchToLogin()
    func didSwitchToRegister()
    func handleAppMovedToForeground()
    func handleAppMovedToBackground()
}
