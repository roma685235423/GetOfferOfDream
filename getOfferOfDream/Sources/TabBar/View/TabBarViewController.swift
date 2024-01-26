import UIKit
import GetOfferDI

// MARK: - TabBarViewController

final class TabBarViewController: UITabBarController {
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarGenerator()
    }
}

// MARK: - Private methods

private extension TabBarViewController {
    
    func itemGenerator(viewController: UIViewController, title: String, type: TabType, tag: Int = 0) -> UINavigationController {
        let thinConfiguration = UIImage.SymbolConfiguration(pointSize: 17, weight: .light)
        
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.tag = tag
        
        let normalImage = UIImage(systemName: type.normalImageName(), withConfiguration: thinConfiguration)
        let selectedImage = UIImage(systemName: type.selectedImageName(), withConfiguration: thinConfiguration)
        
        navigationController.tabBarItem.image = normalImage
        navigationController.tabBarItem.selectedImage = selectedImage
        
        return navigationController
    }

    
    func tabBarGenerator() {
        @Dependency var mainItem: MainItemViewController
        @Dependency var favoritesItem: FavoriteItemViewController
        @Dependency var feedbackItem: FeedbackItemViewController
        @Dependency var profileViewController: ProfileItemViewController
        
        viewControllers = [
            itemGenerator(viewController: mainItem, title: "Main", type: .main),
            itemGenerator(viewController: favoritesItem, title: "Favorites", type: .favorites),
            itemGenerator(viewController: feedbackItem, title: "Feedback", type: .feedback),
            itemGenerator(viewController: profileViewController, title: "Profile", type: .profile)
        ]
    }
}
