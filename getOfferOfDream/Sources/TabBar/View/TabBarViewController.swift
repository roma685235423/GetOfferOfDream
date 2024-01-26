import UIKit
import GetOfferDI

// MARK: - TabBarViewController

private extension TabBarViewController {
    struct ConstantLocalalizedString {
        let main = NSLocalizedString("mainTabBarItem", comment: "")
        let favorite = NSLocalizedString("favoriteTabBarItem", comment: "")
        let feedback = NSLocalizedString("feedbackTabBarItem", comment: "")
        let profile = NSLocalizedString("profileTabBarItem", comment: "")
    }
}

final class TabBarViewController: UITabBarController {
    
    // MARK: Private properties
    private let constants = ConstantLocalalizedString()
    private lazy var myTabBar: UITabBar = {
        return UITabBar(frame: .zero)
    }()
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarGenerator()
    }
}

// MARK: - Private methods

private extension TabBarViewController {
    
    func itemGenerator(viewController: UIViewController, title: String, image: UIImage?, tag: Int = 0) -> UINavigationController {
        let item = UITabBarItem(title: title, image: image, tag: tag)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem = item
        return navigationController
    }
    
    func tabBarGenerator() {
        @Dependency var mainItem: MainItemViewController
        @Dependency var favoritesItem: FavoriteItemViewController
        @Dependency var feedbackItem: FeedbackItemViewController
        @Dependency var profileViewController: ProfileItemViewController
        
        let thinConfiguration = UIImage.SymbolConfiguration(pointSize: 17, weight: .light)

        viewControllers = [
            itemGenerator(
                viewController: mainItem,
                title: constants.main,
                image: UIImage(
                    systemName: "book",
                    withConfiguration: thinConfiguration
                )
            ),
            itemGenerator(
                viewController: favoritesItem,
                title: constants.favorite,
                image: UIImage(
                    systemName: "bookmark",
                    withConfiguration: thinConfiguration
                ),
                tag: 1
            ),
            itemGenerator(
                viewController: feedbackItem,
                title: constants.feedback,
                image: UIImage(
                    systemName: "exclamationmark.bubble",
                    withConfiguration: thinConfiguration
                ),
                tag: 2
            ),
            itemGenerator(
                viewController: profileViewController,
                title: constants.profile,
                image: UIImage(
                    systemName: "person",
                    withConfiguration: thinConfiguration
                ),
                tag: 3
            )
        ]

    }
}
