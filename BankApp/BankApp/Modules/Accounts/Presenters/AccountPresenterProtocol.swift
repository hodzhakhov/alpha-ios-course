import Foundation

protocol AccountsPresenterProtocol: AnyObject {
    func viewDidLoad(userId: String)
    func createAccountTapped(userId: String, currency: Currency)
    func handleAppMovedToBackground()
    func handleAppMovedToForeground()
}
