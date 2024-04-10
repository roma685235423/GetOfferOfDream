import UIKit
import GetOfferDI

final class ThemesRouter: ThemesRouterProtocol {

    // MARK: - Public Properties
    weak var view: UIViewController?

    // MARK: - Public Mehods
    func roteToQuestions(questions: [QuestionViewModel]) {
        QuestionsAssembly.init(questions: questions).assemble()
        @Dependency var questionView: QuestionsViewController
        view?.navigationController?.pushViewController(questionView, animated: true)
    }
}
