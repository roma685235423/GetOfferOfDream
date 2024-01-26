import Foundation
import GetOfferDI

// MARK: - TabBarAssembly

final class TabBarAssembly: Assembly {
    
    func assemble() {
        Container.shared.register(service: TabBarManager.self) { _ in
            TabBarManager()
        }
        Container.shared.register(service: TabBarViewController.self) { _ in
            TabBarViewController()
        }
        @Dependency var view: TabBarViewController
        @Dependency var tabBarManager: TabBarManager
        
        tabBarManager.setup(tabBar: view.tabBar)
    }
}
