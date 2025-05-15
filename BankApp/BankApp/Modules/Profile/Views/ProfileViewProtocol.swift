protocol ProfileViewProtocol: AnyObject {
    func displayProfile(_ user: User)
    func showLoading(_ isLoading: Bool)
    func showError(_ message: String)
    func showProfileUpdated(_ user: User)
}
