import UIKit
import GetOfferDI

// MARK: - ConstantLocalalizedString

fileprivate struct ConstantLocalalizedString {
    let main = NSLocalizedString("mainTabBarItem", comment: "")
    let favorite = NSLocalizedString("favoriteTabBarItem", comment: "")
    let quiiz = NSLocalizedString("quizTabBarItem", comment: "")
    let feedback = NSLocalizedString("feedbackTabBarItem", comment: "")
    let profile = NSLocalizedString("profileTabBarItem", comment: "")
}

// MARK: - TabBarViewController

final class TabBarViewController: UITabBarController {
    
    // MARK: - Private properties
    
    private let constants = ConstantLocalalizedString()
    
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
        @Dependency var quizViewController: QuizItemViewController
        @Dependency var feedbackItem: FeedbackItemViewController
        @Dependency var profileViewController: ProfileItemViewController
        
        viewControllers = [
            itemGenerator(viewController: mainItem, title: constants.main, type: .main),
            itemGenerator(viewController: favoritesItem, title: constants.favorite, type: .favorites),
            itemGenerator(viewController: quizViewController, title: constants.quiiz, type: .quiz),
            itemGenerator(viewController: feedbackItem, title: constants.feedback, type: .feedback),
            itemGenerator(viewController: profileViewController, title: constants.profile, type: .profile)
        ]
    }
}
