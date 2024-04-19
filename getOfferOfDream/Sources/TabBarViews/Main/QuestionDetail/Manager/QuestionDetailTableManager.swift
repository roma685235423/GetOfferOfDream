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
        self.tableView?.separatorStyle = .none
        self.tableView?.register(
            QuestionDetailSegmentCell.self,
            forCellReuseIdentifier: QuestionDetailSegmentCell.description()
        )
    }
}

// MARK: - UITableViewDataSource
extension QuestionDetailTableManager: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getViewModelsCount() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let presenter = presenter,
            let question: QuestionDetailSectionModel = presenter.getViewModelWith(indexPath: indexPath),
            let cell = tableView.dequeueReusableCell(
                withIdentifier: QuestionDetailSegmentCell.description(),
                for: indexPath
            ) as? QuestionDetailSegmentCell
        else { return UITableViewCell() }

        cell.configure(with: question)
        return cell
    }
}

extension QuestionDetailTableManager: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
