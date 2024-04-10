import UIKit

protocol QuestionTableManagerDelegate: AnyObject {
    func update(viewModel: [QuestionViewModel])
    func setupTable(tableView: UITableView)
}
