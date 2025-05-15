import Foundation

protocol TransferViewProtocol: AnyObject {
    func showLoading(_ isLoading: Bool)
    func showError(_ message: String)
    func showTransferSuccess(_ transaction: Transaction)
}
