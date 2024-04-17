import UIKit
import GetOfferCore

final class MainTableManager: NSObject {

    // MARK: - Public Properties
    weak var tableView: UITableView?
    weak var presenter: MainItemPresenterDelegate?
}

// MARK: - MainTableDelegate
extension MainTableManager: TableManagerDelegate {

    func update() {
        self.tableView?.reloadData()
    }

    func setup(tableView: UITableView) {
        self.tableView = tableView
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.separatorStyle = .singleLine
        self.tableView?.backgroundColor = UIColor.opaqueSeparator
    }
}

// MARK: - MainTableManagerProtocol
extension MainTableManager: MainTableManagerProtocol {

    func updateTable() {
        tableView?.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension MainTableManager: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.getViewModelsCount() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let presenter = presenter,
            let themeTitle = presenter.getViewModelWith(indexPath: indexPath)
        else { return UITableViewCell() }

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
        guard let viewModel = presenter?.getViewModelWith(indexPath: indexPath) else { return }

        viewModel.didTap(viewModel.questions)
    }
}
