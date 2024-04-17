import UIKit

protocol MainTableDelegate: AnyObject {
    func update(viewModel: [ThemeViewModel])
    func setup(tableView: UITableView)
}
