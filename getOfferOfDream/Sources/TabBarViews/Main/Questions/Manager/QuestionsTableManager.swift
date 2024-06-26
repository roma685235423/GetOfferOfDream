import UIKit
import GetOfferCore

final class QuestionsTableManager: NSObject {

    // MARK: - Public Properties
    weak var tableView: UITableView?
    weak var presenter: BaseTablePresenterDelegate?
}

// MARK: - MainTableDelegate
extension QuestionsTableManager: BaseTableManagerDelegate {

    func update() {
        self.tableView?.reloadData()
    }

    func setup(tableView: UITableView) {
        self.tableView = tableView
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.separatorStyle = .none
    }
}

// MARK: - UITableViewDataSource
extension QuestionsTableManager: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getViewModelsCount() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let presenter = presenter,
            let questionTitle: QuestionViewModel = presenter.getViewModelWith(indexPath: indexPath)
        else { return UITableViewCell() }

        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        let title = questionTitle.title
        cell.textLabel?.text = title
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - UITableViewDelegate
extension QuestionsTableManager: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard
            let presenter = presenter,
            let tappedCellModel: QuestionViewModel = presenter.getViewModelWith(indexPath: indexPath)
        else { return }

        let model = QuestionDetailViewModel(title: tappedCellModel.title, sections: tappedCellModel.sections)
        tappedCellModel.didTap(model)
    }
}
