import Foundation

final class QuestionDetailPresenter {

    // MARK: - Public Properties
    weak var view: BaseViewControllerProtocol?

    // MARK: - Private Properties
    private let tableManager: BaseTableManagerDelegate
    private var viewModel: QuestionViewModel

    // MARK: - Initializers
    init(tableManager: BaseTableManagerDelegate, viewModel: QuestionViewModel) {
        self.tableManager = tableManager
        self.viewModel = viewModel
    }
}

// MARK: - BaseViewControllerProtocol
extension QuestionDetailPresenter: BaseViewControllerProtocol { }

// MARK: - BaseTablePresenterDelegate
extension QuestionDetailPresenter: BaseTablePresenterDelegate {
    func getViewModelsCount() -> Int {
        return viewModel.sections.count
    }

    func getViewModelWith<T: ViewModel>(indexPath: IndexPath) -> T? {
        let targetSectionViewModel: QuestionDetailSectionModel = viewModel.sections[indexPath.row]
        return targetSectionViewModel as? T
    }
}

// MARK: - BasePresenterDelegate
extension QuestionDetailPresenter: BasePresenterDelegate {
    func viewDidLoad() {
        DispatchQueue.main.async { [weak self] in
            self?.tableManager.update()
        }
    }
}
