import Foundation

struct Transaction {
    let id: String
    let fromAccountId: String
    let toAccountId: String
    let amount: Double
    let currency: Currency
    let date: Date
    var status: TransactionStatus
}
