import Foundation
import GetOfferDI

// MARK: - MainItemAssembly
final class QuizItemAssembly: Assembly {

    // MARK: - Public Properties
    func assemble() {
        Container.shared.register(service: QuizItemViewController.self) { _ in
            QuizItemViewController()
        }
        @Dependency var view: QuizItemViewController

        view.viewDidLoad()
    }

}
