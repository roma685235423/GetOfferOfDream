import UIKit
import GetOfferCore

final class QuestionsTableManager: NSObject {

    // MARK: - Public Properties
    weak var tableView: UITableView?
}

// MARK: - Public Methods
extension QuestionsTableManager: QuestionsManagerProtocol {
    func update(tableView: UITableView) {
        self.tableView = tableView
    }
}
