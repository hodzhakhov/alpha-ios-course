import Foundation

protocol TxHistoryViewProtocol: AnyObject {
    func displayTransactions(_ transactions: [Transaction])
    func showLoading(_ isLoading: Bool)
    func showError(_ message: String)
}
