import UIKit

// MARK: - TabBarManager

final class TabBarManager {
    weak var tabBar: UITabBar?
}

// MARK: - TabBarManagerProtocol

extension TabBarManager: TabBarManagerProtocol {
    func setup(tabBar: UITabBar) {
        self.tabBar = tabBar
        self.tabBar?.tintColor = .black
        self.tabBar?.unselectedItemTintColor = .lightGray
        self.tabBar?.backgroundColor = .white
    }
}
