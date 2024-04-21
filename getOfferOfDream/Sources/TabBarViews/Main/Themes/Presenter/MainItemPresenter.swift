import Foundation
import GetOfferCore

final class MainItemPresenter {

    // MARK: - Public Properties
    weak var view: BaseViewControllerProtocol?

    // MARK: - Private Properties
    private let tableManager: BaseTableManagerDelegate
    private let themes = DataServiceManager.shared.themes
    private let router: ThemesRouterProtocol
    private var viewModels: [ThemeViewModel] = []

    // MARK: - Initializers
    init(tableManager: BaseTableManagerDelegate, router: ThemesRouterProtocol) {
        self.tableManager = tableManager
        self.router = router
    }
}

// MARK: - BaseTablePresenterDelegate
extension MainItemPresenter: BaseTablePresenterDelegate {

    func getViewModelsCount() -> Int {
        viewModels.count
    }

    func getViewModelWith<T: ViewModel>(indexPath: IndexPath) -> T? {
        let targetViewModel: ThemeViewModel = viewModels[indexPath.row]
        return targetViewModel as? T
    }
}

// MARK: - MainItemPresenterProtocol
extension MainItemPresenter: BasePresenterDelegate {

    func viewDidLoad() {
        createViewModel(themes: themes)
    }
}

// MARK: - Private Methods
private extension MainItemPresenter {

    func createViewModel(themes: [ThemeModel]) {
        for theme in themes {
            let themeModel = ThemeViewModel(
                theme: theme
            ) { [weak self] _ in
                self?.router.roteToQuestions(theme: theme)
            }
            viewModels.append(themeModel)
        }

        DispatchQueue.main.async { [weak self] in
            self?.tableManager.update()
        }
    }
}
