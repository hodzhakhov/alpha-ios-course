import Foundation

protocol AccountsViewProtocol: AnyObject {
    func displayAccounts(_ accounts: [Account])
    func showLoading(_ isLoading: Bool)
    func showError(_ message: String)
    func showAccountCreated(_ account: Account)
}
