import UIKit
import GetOfferUI

// MARK: - MainItemViewController
final class MainItemViewController: UIViewController {

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
        view.backgroundColor = .whiteDynamic
        presenter?.viewDidLoad()
        view.addSubviews([tableView])
        setConstraints()
        self.title = "Список тем"
    }
}

// MARK: - BaseViewControllerProtocol
extension MainItemViewController: BaseViewControllerProtocol { }

// MARK: - Private Methods
private extension MainItemViewController {

    func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Constants.horizontalIndent),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Constants.horizontalIndent),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
