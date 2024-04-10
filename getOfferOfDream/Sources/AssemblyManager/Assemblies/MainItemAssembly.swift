import Foundation
import GetOfferDI

// MARK: - MainItemAssembly
final class MainItemAssembly: Assembly {

    // MARK: - Public Properties
    func assemble() {

        Container.shared.register(service: MainTableManager.self) { _ in
            MainTableManager()
        }

        Container.shared.register(service: ThemesRouter.self) { _ in
            ThemesRouter()
        }

        Container.shared.register(service: MainItemPresenter.self) { resolve in
            let tableManager: MainTableManager = resolve.resolve()
            let router: ThemesRouter = resolve.resolve()
            return MainItemPresenter(tableManager: tableManager, router: router)
        }

        Container.shared.register(service: MainItemViewController.self) { resolve in
            let presenter: MainItemPresenter = resolve.resolve()
            return MainItemViewController(presenter: presenter)
        }

        @Dependency var presenter: MainItemPresenter
        @Dependency var view: MainItemViewController
        @Dependency var tableManager: MainTableManager
        @Dependency var router: ThemesRouter

        presenter.view = view
        router.view = view
        tableManager.setupTable(tableView: view.tableView)
    }
}
