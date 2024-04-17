import Foundation
import GetOfferCore

// MARK: - FavoriteItemPresenter
final class FavoriteItemPresenter {

    // MARK: - Public Properties
    weak var view: FavoriteItemViewInput?
}

// MARK: - FavoriteItemViewDelegate
extension FavoriteItemPresenter: FavoriteItemViewDelegate {

    func viewDidLoad() {
        updateSwitches()
    }
}

// MARK: - Private methods
private extension FavoriteItemPresenter {
    func updateSwitches() {

    }
}
