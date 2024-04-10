import Foundation
import GetOfferCore

final class MainItemPresenter {

    // MARK: - Public Properties
    weak var view: MainItemViewInput?

    // MARK: - Private Properties
    private let tableManager: MainTableDelegate
    private let themes = DataServiceManager.shared.themes
    private let router: ThemesRouterProtocol

    // MARK: - Initializers
    init(tableManager: MainTableDelegate, router: ThemesRouterProtocol) {
        self.tableManager = tableManager
        self.router = router
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
        var viewModels = [ThemeViewModel]()
        for theme in themes {

            var questions = [QuestionViewModel]()
            for question in theme.questions {

                let questionsModel = QuestionViewModel(
                    title: question.title,
                    text: question.text,
                    images: question.images
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
            self?.tableManager.update(viewModel: viewModels)
        }
    }
}
