import Foundation
import UIKit

class TableManager: NSObject, TableManagerProtocol {
    private var tableView: UITableView?
    private var viewModels: [CurrencyRateCellViewModel] = []
    weak var delegate: TableManagerDelegate?
    
    func setup(with tableView: UITableView) {
        self.tableView = tableView
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CurrencyRateCell.self, forCellReuseIdentifier: CurrencyRateCell.reuseIdentifier)
    }
    
    func update(with models: [CurrencyRateCellViewModel]) {
        self.viewModels = models
        tableView?.reloadData()
    }
}

extension TableManager: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyRateCell.reuseIdentifier, for: indexPath) as? CurrencyRateCell else {
            return UITableViewCell()
        }
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectRate(viewModels[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
