import UIKit
import GetOfferCore

final class MainTableManager: NSObject {

    // MARK: - Public Properties
    weak var tableView: UITableView?

    // MARK: - Private Properties
    private var viewModel: [ThemeViewModel] = []
}

// MARK: - Public Methods
extension MainTableManager: MainTableDelegate {

    func update(viewModel: [ThemeViewModel]) {
        self.viewModel = viewModel
        self.tableView?.reloadData()
    }

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
        viewModel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let themeTitle = viewModel[indexPath.row]
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)

        let title = themeTitle.title
        cell.textLabel?.text = title
        cell.textLabel?.textColor = .black
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - UITableViewDelegate
extension MainTableManager: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = viewModel[indexPath.row]

        viewModel.didTap(viewModel.questions)
    }
}

// MARK: - MainTableManagerProtocol
extension MainTableManager: MainTableManagerProtocol {

    func updateTable() {
        tableView?.reloadData()
    }
}
