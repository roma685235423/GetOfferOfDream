import Foundation
import GetOfferCore

// MARK: - FavoriteItemPresenter
final class FavoriteItemPresenter {

    // MARK: - Public Properties
    weak var view: FavoriteItemViewInput?
}

// MARK: - FavoriteItemViewDelegate
extension FavoriteItemPresenter: BasePresenterProtocol {

    func viewDidLoad() { }
}
