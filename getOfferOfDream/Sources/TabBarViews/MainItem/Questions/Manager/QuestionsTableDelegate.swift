import UIKit

protocol QuestionTableManagerDelegate: AnyObject {
    func update()
    func setupTable(tableView: UITableView)
}
