import Foundation

// MARK: - TabBarPresenter

final class TabBarPresenter {
    
    // MARK: Public properties
    
    weak var view: TabBarViewInput?
    
    private let tabBar: TabBarManagerProtocol
    
    // MARK: Life cycle
    
    init(tabBar: TabBarManagerProtocol) {
        self.tabBar = tabBar
    }
}


// MARK: - TabBarPresenterProtocol

extension TabBarPresenter: TabBarPresenterProtocol {
    func viewDidLoad() {
        //
    }
}
