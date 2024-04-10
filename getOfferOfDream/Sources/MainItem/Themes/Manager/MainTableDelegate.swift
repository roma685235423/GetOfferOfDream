import UIKit

protocol MainTableDelegate: AnyObject {
    func update(viewModel: [ThemeViewModel])
    func setupTable(tableView: UITableView)
}
