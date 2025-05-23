protocol AuthPresenterProtocol: AnyObject {
    func loginButtonTapped(email: String, password: String)
    func registerButtonTapped(email: String, password: String, confirmPassword: String)
    func validateInput(email: String, password: String, confirmPassword: String?)
    func toggleAuthMode()
    func authButtonTapped(email: String, password: String, confirmPassword: String?)
}
