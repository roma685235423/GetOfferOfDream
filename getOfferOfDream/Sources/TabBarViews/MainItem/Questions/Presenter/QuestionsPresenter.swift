import Foundation
import GetOfferCore

final class QuestionsPresenter {

    // MARK: - Public Properties
    weak var view: QuestionsViewDelegate?

    // MARK: - Private Properties
    private let tableManager: QuestionTableManagerDelegate
    private var questions: [QuestionModel]
    private var viewModels: [QuestionViewModel] = []

    // MARK: - Initializers
    init(tableManager: QuestionTableManagerDelegate, questions: [QuestionModel]) {
        self.tableManager = tableManager
        self.questions = questions
    }
}

// MARK: - QuestionsViewDelegate
extension QuestionsPresenter: QuestionsViewDelegate { }

// MARK: - QuestionPresenterDelegate
extension QuestionsPresenter: QuestionPresenterDelegate {

    func getViewModelsCount() -> Int {
        return viewModels.count
    }

    func getViewModelWith(indexPath: IndexPath) -> QuestionViewModel? {
        return viewModels[indexPath.row]
    }
}

// MARK: - QuestionsPresenterProtocol
extension QuestionsPresenter: QuestionsPresenterProtocol {
    func viewDidLoad() {
        createViewModel(questions: questions)
    }
}

// MARK: - Private Methods
private extension QuestionsPresenter {

    func createViewModel(questions: [QuestionModel]) {
        for question in questions {
            let questionViewModel = QuestionViewModel(
                title: question.title,
                text: question.text,
                images: question.images
            ) { _ in
                print(#function)
            }
            self.viewModels.append(questionViewModel)
        }

        DispatchQueue.main.async { [weak self] in
            self?.tableManager.update()
        }
    }
}
