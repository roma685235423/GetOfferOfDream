import UIKit

final class QuestionDetailTableManager: NSObject {

    // MARK: - Public Properties
    weak var tableView: UITableView?
    weak var presenter: QuestionTablePresenterDelegate?
}

// MARK: - BaseTableManagerDelegate
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
        self.tableView?.register(
            QuestionDetailHeader.self,
            forHeaderFooterViewReuseIdentifier: QuestionDetailHeader.description()
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

        switch indexPath.row {
        case 0:
            cell.setImage(image: GetOfferOfDreamAsset.testImage2.image)
        case 1:
            cell.setImage(image: GetOfferOfDreamAsset.testImage1.image)
        default:
            break
        }
        return cell
    }
}

// MARK: - UITableViewDelegate
extension QuestionDetailTableManager: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard
            let presenter = presenter,
            let header = tableView.dequeueReusableHeaderFooterView(
                withIdentifier: QuestionDetailHeader.description()
            ) as? QuestionDetailHeader else {
            return UIView()
        }
        header.configure(with: presenter.getQuestionHeader())
        return header
    }
}
