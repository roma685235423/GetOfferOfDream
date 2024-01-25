import UIKit
import GetOfferDI

// MARK: - TabBarViewController

private extension TabBarViewController {
    struct ConstantLocalalizedString {
        let first = NSLocalizedString("firstTabBarItem", comment: "")
        let second = NSLocalizedString("secondTabBarItem", comment: "")
        let third = NSLocalizedString("thirdTabBarItem", comment: "")
    }
}

final class TabBarViewController: UITabBarController {
    
    // MARK: Private properties
//    private let presenter: TabBarPresenterProtocol
    private let constants = ConstantLocalalizedString()
    private lazy var myTabBar: UITabBar = {
        return UITabBar(frame: .zero)
    }()
    
    // MARK: Life cycle
//    init(presenter: TabBarPresenterProtocol) {
//        self.presenter = presenter
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - TabBarViewInput

//extension TabBarViewController: TabBarViewInput { }
