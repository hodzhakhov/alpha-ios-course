protocol TransferPresenterProtocol: AnyObject {
    func transferTapped(fromAccountId: String, toAccountId: String, amount: Double, currency: Currency)
}
