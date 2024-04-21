import UIKit
import GetOfferDI

final class ThemesRouter: ThemesRouterProtocol {

    // MARK: - Public Properties
    weak var view: UIViewController?

    // MARK: - Public Mehods
    func roteToQuestions(theme: ThemeModel) {
        QuestionsAssembly.init(questions: theme).assemble()
        @Dependency var questionView: QuestionsViewController
        questionView.title = theme.title
        view?.navigationController?.pushViewController(questionView, animated: true)
    }
}
