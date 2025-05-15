import Foundation

protocol TransferInteractorProtocol: AnyObject {
    func makeTransfer(fromAccountId: String, toAccountId: String, amount: Double, currency: Currency, completion: @escaping (Result<Transaction, Error>) -> Void)
}
