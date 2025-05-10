import Foundation

protocol DataStoreFacade {
    func login(login: String, password: String, completion: @escaping (Result<User, Error>) -> Void)
    
    func register(login: String, password: String, completion: @escaping (Result<User, Error>) -> Void)
    
    func fetchAccounts(userId: String, completion: @escaping (Result<[Account], Error>) -> Void)
    
    func createAccount(userId: String, currency: Currency, completion: @escaping (Result<Account, Error>) -> Void)
    
    func makeTransfer(fromAccountId: String, toAccountId: String, amount: Double, currency: Currency, completion: @escaping (Result<Transaction, Error>) -> Void)
    
    func fetchTransactions(accountId: String, completion: @escaping (Result<[Transaction], Error>) -> Void)
    
    func fetchUserProfile(userId: String, completion: @escaping (Result<User, Error>) -> Void)
    
    func updateUserProfile(userId: String, name: String?, completion: @escaping (Result<User, Error>) -> Void)
}
