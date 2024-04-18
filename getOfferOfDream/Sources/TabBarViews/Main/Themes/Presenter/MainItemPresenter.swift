import Foundation
import GetOfferCore

final class MainItemPresenter {

    // MARK: - Public Properties
    weak var view: BaseViewControllerProtocol?

    // MARK: - Private Properties
    private let tableManager: BaseTableManagerDelegate
    private let themes = DataServiceManager.shared.themes
    private let router: ThemesRouterProtocol
    private var viewModels: [ThemeViewModel] = []

    // MARK: - Initializers
    init(tableManager: BaseTableManagerDelegate, router: ThemesRouterProtocol) {
        self.tableManager = tableManager
        self.router = router
    }
}

// MARK: - BaseTablePresenterDelegate
extension MainItemPresenter: BaseTablePresenterDelegate {
    func getViewModelsCount() -> Int {
        viewModels.count
    }

    func getViewModelWith<T: ViewModel>(indexPath: IndexPath) -> T? {
        let targetViewModel: ThemeViewModel = viewModels[indexPath.row]
        return targetViewModel as? T
    }
}

// MARK: - MainItemPresenterProtocol
extension MainItemPresenter: BasePresenterDelegate {
    func viewDidLoad() {
        createViewModel(themes: themes)
    }
}

// MARK: - Private Methods
private extension MainItemPresenter {

    func createViewModel(themes: [ThemeModel]) {
        for theme in themes {

            var questions = [QuestionModel]()
            for question in theme.questions {

                let questionsModel = QuestionModel(
                    title: question.title,
                    sections: question.sections
                )
                questions.append(questionsModel)
            }

            let themeModel = ThemeViewModel(
                title: theme.title,
                questions: questions
            ) { [weak self] questions in
                self?.router.roteToQuestions(questions: questions)
            }
            viewModels.append(themeModel)
        }

        DispatchQueue.main.async { [weak self] in
            self?.tableManager.update()
        }
    }
}
