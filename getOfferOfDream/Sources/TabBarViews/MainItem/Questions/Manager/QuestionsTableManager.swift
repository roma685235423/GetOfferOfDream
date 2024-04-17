import UIKit
import GetOfferCore

final class QuestionsTableManager: NSObject {

    // MARK: - Public Properties
    weak var tableView: UITableView?
    weak var presenter: QuestionPresenterDelegate?
}

// MARK: - MainTableDelegate
extension QuestionsTableManager: QuestionTableManagerDelegate {

    func update() {
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

// MARK: - Public Methods
extension QuestionsTableManager: QuestionsManagerProtocol {

    func updateTable() {
        tableView?.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension QuestionsTableManager: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.getViewModelsCount() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let presenter = presenter,
            let questionTitle = presenter.getViewModelWith(indexPath: indexPath)
        else { return UITableViewCell() }

        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)

        let title = questionTitle.title
        cell.textLabel?.text = title
        cell.textLabel?.textColor = .black
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - UITableViewDelegate
extension QuestionsTableManager: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tappedCellModel = presenter?.getViewModelWith(indexPath: indexPath)
        print("Did tap -> \(tappedCellModel?.title ?? "nil")\n")
    }
}
