import Foundation
import GetOfferDI

// MARK: - MainItemAssembly
final class FeedbackItemAssembly: Assembly {

    // MARK: - Public Properties
    func assemble() {
        Container.shared.register(service: FeedbackItemViewController.self) { _ in
            FeedbackItemViewController()
        }
        @Dependency var view: FeedbackItemViewController

        view.viewDidLoad()
    }

}
