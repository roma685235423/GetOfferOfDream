import Foundation
import GetOfferCore

final class MainItemPresenter {

    // MARK: - Public Properties
    weak var view: MainItemViewDelegate?

    // MARK: - Private Properties
    private let tableManager: TableManagerDelegate
    private let themes = DataServiceManager.shared.themes
    private let router: ThemesRouterProtocol
    private var viewModels: [ThemeViewModel] = []

    // MARK: - Initializers
    init(tableManager: TableManagerDelegate, router: ThemesRouterProtocol) {
        self.tableManager = tableManager
        self.router = router
    }
}

extension MainItemPresenter: MainItemPresenterDelegate {
    func getViewModelsCount() -> Int {
        return viewModels.count
    }

    func getViewModelWith(indexPath: IndexPath) -> ThemeViewModel? {
        return viewModels[indexPath.row]
    }
}

// MARK: - MainItemPresenterProtocol
extension MainItemPresenter: MainItemPresenterProtocol {
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
