import Foundation

protocol TxHistoryPresenterProtocol: AnyObject {
    func viewDidLoad(accountId: String)
    func handleAppMovedToBackground()
    func handleAppMovedToForeground()
}
