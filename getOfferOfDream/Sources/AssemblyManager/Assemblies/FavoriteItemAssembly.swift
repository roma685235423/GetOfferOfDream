import Foundation
import GetOfferDI
import GetOfferCore

// MARK: - MainItemAssembly
final class FavoriteItemAssembly: Assembly {

    // MARK: - Public Properties
    func assemble() {

        Container.shared.register(service: FavoriteItemPresenter.self) { _ in
            return FavoriteItemPresenter()
        }

        Container.shared.register(service: FavoriteItemViewController.self) { resolve in
            let presenter: FavoriteItemPresenter = resolve.resolve()
            return FavoriteItemViewController(presenter: presenter)
        }
        @Dependency var view: FavoriteItemViewController
        @Dependency var presenter: FavoriteItemPresenter
        @Dependency var service: AudioPlayerService
        @Dependency var storage: AudioPlayerUserDefaultsService

        presenter.storage = storage
        presenter.view = view
        storage.audioService = service

        view.viewDidLoad()
    }
}
