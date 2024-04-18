import UIKit
import GetOfferUI
import GetOfferCore

// MARK: - FavoriteItemViewController
class FavoriteItemViewController: UIViewController {

    // MARK: - Private Properties
    private let presenter: BasePresenterProtocol

    init(presenter: BasePresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Overrides Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemCyan
    }
}

// MARK: - FavoriteItemViewInput
extension FavoriteItemViewController: FavoriteItemViewInput { }

// MARK: - Private Methods
private extension FavoriteItemViewController {

    func setConstraints() {
        NSLayoutConstraint.activate([ ])
    }
}
