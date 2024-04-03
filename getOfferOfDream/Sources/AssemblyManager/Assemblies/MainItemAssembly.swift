import Foundation
import GetOfferDI
import GetOfferCore

// MARK: - MainItemAssembly
final class MainItemAssembly: Assembly {

    // MARK: - Public Properties
    func assemble() {

        Container.shared.register(service: MainTableManager.self) { _ in
            MainTableManager()
        }

        Container.shared.register(service: AudioPlayerUserDefaultsService.self) { _ in
            AudioPlayerUserDefaultsService()
        }

        Container.shared.register(service: AudioPlayerService.self) { resolve in
            let storage: AudioPlayerUserDefaultsService = resolve.resolve()
            return AudioPlayerService(storage: storage)
        }

        Container.shared.register(service: MainItemPresenter.self) { resolve in
            let tableManager: MainTableManager = resolve.resolve()
            let audioService: AudioPlayerService = resolve.resolve()
            return MainItemPresenter(tableManager: tableManager,
                                     audioService: audioService)
        }

        Container.shared.register(service: MainItemViewController.self) { resolve in
            let presenter: MainItemPresenter = resolve.resolve()
            return MainItemViewController(presenter: presenter)
        }

        @Dependency var presenter: MainItemPresenter
        @Dependency var view: MainItemViewController
        @Dependency var tableManager: MainTableManager
        @Dependency var service: AudioPlayerService
        @Dependency var storage: AudioPlayerUserDefaultsService

        storage.audioService = service
        tableManager.presenter = presenter
        tableManager.setupTable(tableView: view.tableView)
    }
}
