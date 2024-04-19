import UIKit
import GetOfferDI

final class ThemesRouter: ThemesRouterProtocol {

    // MARK: - Public Properties
    weak var view: UIViewController?

    // MARK: - Public Mehods
    func roteToQuestions(themeTitle: String, questions: [QuestionModel]) {
        QuestionsAssembly.init(questions: questions).assemble()
        @Dependency var questionView: QuestionsViewController
        questionView.title = themeTitle
        view?.navigationController?.pushViewController(questionView, animated: true)
    }
}
