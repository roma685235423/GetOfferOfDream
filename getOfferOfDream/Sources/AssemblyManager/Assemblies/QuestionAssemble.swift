import Foundation
import GetOfferDI

// MARK: - QuestionsAssembly
final class QuestionsAssembly: Assembly {

    // MARK: - Public Properties
    var questions: [QuestionViewModel]

    // MARK: - Initializers
    init(questions: [QuestionViewModel]) {
        self.questions = questions
    }

    // MARK: - Public Methods
    func assemble() {

        Container.shared.register(service: QuestionsTableManager.self) { _ in
            QuestionsTableManager()
        }

        Container.shared.register(service: QuestionsPresenter.self) { resolver in
            let tableManager: QuestionsTableManager = resolver.resolve()
            return QuestionsPresenter(tableManager: tableManager, questions: self.questions)
        }

        Container.shared.register(service: QuestionsViewController.self) { resolver in
            let presenter: QuestionsPresenter = resolver.resolve()
            return QuestionsViewController(presenter: presenter)
        }

        @Dependency var view: QuestionsViewController
        @Dependency var presenter: QuestionsPresenter
        @Dependency var tableManager: QuestionsTableManager

        presenter.view = view
        tableManager.update(tableView: view.tableView)
    }
}
