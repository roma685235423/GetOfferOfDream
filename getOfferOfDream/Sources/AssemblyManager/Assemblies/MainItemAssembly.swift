import Foundation
import GetOfferDI

// MARK: - MainItemAssembly
final class MainItemAssembly: Assembly {

    // MARK: - Public Properties
    func assemble() {

        Container.shared.register(service: MainTableManager.self) { _ in
            MainTableManager()
        }

        Container.shared.register(service: MainItemPresenter.self) { resolve in
            let tableManager: MainTableManager = resolve.resolve()
            return MainItemPresenter(tableManager: tableManager)
        }

        Container.shared.register(service: MainItemViewController.self) { resolve in
            let presenter: MainItemPresenter = resolve.resolve()
            return MainItemViewController(presenter: presenter)
        }

        @Dependency var presenter: MainItemPresenter
        @Dependency var view: MainItemViewController
        @Dependency var tableManager: MainTableManager

        tableManager.presenter = presenter
        tableManager.setupTable(tableView: view.tableView)
    }

}
