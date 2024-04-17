import UIKit

protocol TableManagerDelegate: AnyObject {
    func update()
    func setup(tableView: UITableView)
}
