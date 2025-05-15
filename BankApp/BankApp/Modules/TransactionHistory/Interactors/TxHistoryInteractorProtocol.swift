import Foundation

protocol TxHistoryInteractorProtocol: AnyObject {
    func fetchTransactions(accountId: String, completion: @escaping (Result<[Transaction], Error>) -> Void)
}
