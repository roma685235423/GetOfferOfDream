import Foundation
import GetOfferDI

// MARK: - QuestionsAssembly
final class QuestionsAssembly: Assembly {

    // MARK: - Public Properties
    var questions: [QuestionModel]

    // MARK: - Initializers
    init(questions: [QuestionModel]) {
        self.questions = questions
    }

    // MARK: - Public Methods
    func assemble() {

        Container.shared.register(service: QuestionsTableManager.self) { _ in
            QuestionsTableManager()
        }

        Container.shared.register(service: QuestionsRouter.self) { _ in
            QuestionsRouter()
        }

        Container.shared.register(service: QuestionsPresenter.self) { resolver in
            let tableManager: QuestionsTableManager = resolver.resolve()
            let router: QuestionsRouter = resolver.resolve()
            return QuestionsPresenter(tableManager: tableManager, router: router, questions: self.questions)
        }

        Container.shared.register(service: QuestionsViewController.self) { resolver in
            let presenter: QuestionsPresenter = resolver.resolve()
            return QuestionsViewController(presenter: presenter)
        }

        @Dependency var view: QuestionsViewController
        @Dependency var presenter: QuestionsPresenter
        @Dependency var tableManager: QuestionsTableManager
        @Dependency var router: QuestionsRouter

        presenter.view = view
        router.view = view
        tableManager.presenter = presenter
        tableManager.setup(tableView: view.tableView)
    }
}
