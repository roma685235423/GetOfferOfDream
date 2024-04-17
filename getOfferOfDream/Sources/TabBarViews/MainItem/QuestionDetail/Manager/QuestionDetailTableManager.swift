import UIKit

final class QuestionDetailTableManager: NSObject {

    // MARK: - Public Properties
    weak var tableView: UITableView?

    // MARK: - Private Properties
    private var viewModels: [QuestionDetailViewModel]?
}
