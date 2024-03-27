import UIKit
import GetOfferCore

final class MainTableManager: NSObject {

    // MARK: - Public Properties
    weak var tableView: UITableView?
    weak var presenter: MainItemPresenterProtocol?
}

// MARK: - Public Methods
extension MainTableManager: MainTableDelegate {

    func setupTable(tableView: UITableView) {
        self.tableView = tableView
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.separatorStyle = .singleLine
        self.tableView?.backgroundColor = UIColor.opaqueSeparator
    }
}

// MARK: - UITableViewDataSource
extension MainTableManager: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.getItemsCount() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        let title = presenter?.getTitle(for: indexPath)
        cell.textLabel?.text = title
        cell.textLabel?.textColor = .black
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - UITableViewDelegate
extension MainTableManager: UITableViewDelegate {}

// MARK: - MainTableManagerProtocol
extension MainTableManager: MainTableManagerProtocol {

    func updateTable() {
        tableView?.reloadData()
    }
}
