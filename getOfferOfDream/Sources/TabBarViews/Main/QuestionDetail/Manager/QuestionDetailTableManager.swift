import UIKit

final class QuestionDetailTableManager: NSObject {

    // MARK: - Public Properties
    weak var tableView: UITableView?
    weak var presenter: BaseTablePresenterDelegate?
}

// MARK: - MainTableDelegate
extension QuestionDetailTableManager: BaseTableManagerDelegate {
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

// MARK: - UITableViewDataSource
extension QuestionDetailTableManager: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.getViewModelsCount() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let presenter = presenter,
            let questionTitle: QuestionViewModel = presenter.getViewModelWith(indexPath: indexPath)
        else { return UITableViewCell() }

        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)

        let title = questionTitle.title
        cell.textLabel?.text = title
        cell.textLabel?.textColor = .black
        cell.selectionStyle = .none
        return cell
    }
}
