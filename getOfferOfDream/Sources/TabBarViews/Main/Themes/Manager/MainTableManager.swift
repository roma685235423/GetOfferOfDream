import UIKit
import GetOfferCore

final class MainTableManager: NSObject {

    // MARK: - Public Properties
    weak var tableView: UITableView?
    weak var presenter: BaseTablePresenterDelegate?
}

// MARK: - MainTableDelegate
extension MainTableManager: BaseTableManagerDelegate {

    func update() {
        self.tableView?.reloadData()
    }

    func setup(tableView: UITableView) {
        self.tableView = tableView
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.separatorStyle = .singleLine
    }
}

// MARK: - UITableViewDataSource
extension MainTableManager: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getViewModelsCount() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let presenter = presenter,
            let themeTitle: ThemeViewModel = presenter.getViewModelWith(indexPath: indexPath)
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
        guard
            let presenter = presenter,
            let viewModel: ThemeViewModel = presenter.getViewModelWith(indexPath: indexPath)
        else { return }

        viewModel.didTap(viewModel.questions)
    }
}
