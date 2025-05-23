import UIKit

protocol TableManagerProtocol: AnyObject {
    var delegate: TableManagerDelegate? { get set }
    func setup(with tableView: UITableView)
    func update(with models: [CurrencyRateCellViewModel])
}

protocol TableManagerDelegate: AnyObject {
    func didSelectRate(_ viewModel: CurrencyRateCellViewModel)
}
