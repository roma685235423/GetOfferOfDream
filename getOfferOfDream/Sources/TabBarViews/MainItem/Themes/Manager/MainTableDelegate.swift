import UIKit

protocol MainTableDelegate: AnyObject {
    func update()
    func setup(tableView: UITableView)
}
