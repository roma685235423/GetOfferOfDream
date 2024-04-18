import UIKit
import GetOfferUI

// MARK: - QuestionsViewController
final class QuestionsViewController: UIViewController {

    // MARK: - Public Properties
    let tableView = UITableView(frame: .zero, style: .plain)

    // MARK: - Private Properties
    private let presenter: BasePresenterDelegate?

    // MARK: - Initializers
    init(presenter: BasePresenterDelegate) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Overrides Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .opaqueSeparator
        presenter?.viewDidLoad()
        view.addSubviews([tableView])
        setConstraints()
    }

}

// MARK: - QuestionsViewDelegate
extension QuestionsViewController: BaseViewControllerProtocol { }

// MARK: - Private Methods
private extension QuestionsViewController {

    func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Constansts.horizontalIndent),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Constansts.horizontalIndent),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}