import Foundation
import GetOfferCore

final class QuestionsPresenter {

    // MARK: - Public Properties
    weak var view: QuestionsViewDelegate?

    // MARK: - Private Properties
    private let tableManager: QuestionsManagerProtocol
    private var questions: [QuestionViewModel]

    // MARK: - Initializers
    init(tableManager: QuestionsManagerProtocol, questions: [QuestionViewModel]) {
        self.tableManager = tableManager
        self.questions = questions
    }
}

// MARK: - QuestionsViewDelegate
extension QuestionsPresenter: QuestionsViewDelegate { }

// MARK: - QuestionsPresenterProtocol
extension QuestionsPresenter: QuestionsPresenterProtocol {
    func viewDidLoad() {
        //
    }
}
