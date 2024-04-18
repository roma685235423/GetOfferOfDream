import UIKit
import GetOfferDI

final class QuestionsRouter: QuestionsRouterProtocol {

    // MARK: - Public Properties
    weak var view: UIViewController?

    // MARK: - Public Mehods
    func roteToDetails(with model: QuestionDetailViewModel) {
        QuestionDetailAssembly(questionModel: model).assemble()
        @Dependency var questiosDetailView: QuestionDetailViewController
        view?.navigationController?.pushViewController(questiosDetailView, animated: true)
    }
}
