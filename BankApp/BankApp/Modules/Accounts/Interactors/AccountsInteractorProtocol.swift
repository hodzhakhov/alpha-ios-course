import Foundation

protocol AccountsInteractorProtocol: AnyObject {
    func fetchAccounts(userId: String, completion: @escaping (Result<[Account], Error>) -> Void)
    func createAccount(userId: String, currency: Currency, completion: @escaping (Result<Account, Error>) -> Void)
}
