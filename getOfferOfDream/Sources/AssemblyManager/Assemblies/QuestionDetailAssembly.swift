import Foundation
import GetOfferDI

// MARK: - QuestionDetailAssembly
final class QuestionDetailAssembly: Assembly {

    // MARK: - Public Properties
    var questionModel: QuestionDetailViewModel

    // MARK: - Initializers
    init(questionModel: QuestionDetailViewModel) {
        self.questionModel = questionModel
    }

    // MARK: - Public Methods
    func assemble() {

        Container.shared.register(service: QuestionDetailTableManager.self) { _ in
            QuestionDetailTableManager()
        }

        Container.shared.register(service: QuestionDetailPresenter.self) { resolver in
            let tableManager: QuestionDetailTableManager = resolver.resolve()
            return QuestionDetailPresenter(tableManager: tableManager, viewModel: self.questionModel)
        }

        Container.shared.register(service: QuestionDetailViewController.self) { resolver in
            let presenter: QuestionDetailPresenter = resolver.resolve()
            return QuestionDetailViewController(presenter: presenter)
        }

        @Dependency var view: QuestionDetailViewController
        @Dependency var presenter: QuestionDetailPresenter
        @Dependency var tableManager: QuestionDetailTableManager

        presenter.view = view
        tableManager.presenter = presenter
        tableManager.setup(tableView: view.tableView)
    }
}
