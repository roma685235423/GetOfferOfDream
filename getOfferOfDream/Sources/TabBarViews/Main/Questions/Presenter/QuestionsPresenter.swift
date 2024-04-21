import Foundation

final class QuestionsPresenter {

    // MARK: - Public Properties
    weak var view: BaseViewControllerProtocol?

    // MARK: - Private Properties
    private let tableManager: BaseTableManagerDelegate
    private let router: QuestionsRouter
    private var questions: ThemeModel
    private var viewModels: [QuestionViewModel] = []

    // MARK: - Initializers
    init(tableManager: BaseTableManagerDelegate, router: QuestionsRouter, questions: ThemeModel) {
        self.tableManager = tableManager
        self.router = router
        self.questions = questions
    }
}

// MARK: - BaseViewControllerProtocol
extension QuestionsPresenter: BaseViewControllerProtocol { }

// MARK: - BaseTablePresenterDelegate
extension QuestionsPresenter: BaseTablePresenterDelegate {

    func getViewModelsCount() -> Int {
        return viewModels.count
    }

    func getViewModelWith<T: ViewModel>(indexPath: IndexPath) -> T? {
        let targetViewModel: QuestionViewModel = viewModels[indexPath.row]
        return targetViewModel as? T
    }
}

// MARK: - BasePresenterDelegate
extension QuestionsPresenter: BasePresenterDelegate {
    func viewDidLoad() {
        createViewModel(questions: questions.questions)
    }
}

// MARK: - Private Methods
private extension QuestionsPresenter {

    func createViewModel(questions: [QuestionModel]) {
        for question in questions {
            let questionViewModel = QuestionViewModel(
                title: question.title,
                sections: question.sections
            ) { [weak self] question in
                guard let self = self else { return }
                let targetQuestion = QuestionDetailViewModel(title: question.title, sections: question.sections)
                self.router.roteToDetails(themeTitle: self.questions.title, with: targetQuestion)
            }
            self.viewModels.append(questionViewModel)
        }

        DispatchQueue.main.async { [weak self] in
            self?.tableManager.update()
        }
    }
}
