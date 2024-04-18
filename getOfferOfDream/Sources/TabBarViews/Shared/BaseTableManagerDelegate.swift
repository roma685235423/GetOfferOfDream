import UIKit

protocol BaseTableManagerDelegate: AnyObject {
    func update()
    func setup(tableView: UITableView)
}
