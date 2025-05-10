import Foundation

protocol TransferPresenterProtocol: AnyObject {
    func transferTapped(fromAccountId: String, toAccountId: String, amount: Double, currency: Currency)
    func handleAppMovedToBackground()
    func handleAppMovedToForeground()
}
