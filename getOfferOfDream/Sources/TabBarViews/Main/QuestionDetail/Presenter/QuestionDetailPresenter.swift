import Foundation

final class QuestionDetailPresenter {

    // MARK: - Public Properties
    weak var view: BaseViewControllerProtocol?

    // MARK: - Private Properties
    private let tableManager: BaseTableManagerDelegate
    private var questionDetailViewModel: QuestionDetailViewModel

    // MARK: - Initializers
    init(tableManager: BaseTableManagerDelegate, viewModel: QuestionDetailViewModel) {
        self.tableManager = tableManager
        self.questionDetailViewModel = viewModel
    }
}

// MARK: - BaseViewControllerProtocol
extension QuestionDetailPresenter: BaseViewControllerProtocol { }

// MARK: - BaseTablePresenterDelegate
extension QuestionDetailPresenter: BaseTablePresenterDelegate {
    func getViewModelsCount() -> Int {
        return questionDetailViewModel.sections.count
    }

    func getViewModelWith<T: ViewModel>(indexPath: IndexPath) -> T? {
        let targetSectionViewModel: QuestionDetailSectionModel = questionDetailViewModel.sections[indexPath.row]
        return targetSectionViewModel as? T
    }
}

// MARK: - BasePresenterDelegate
extension QuestionDetailPresenter: BasePresenterDelegate {
    func viewDidLoad() {
        createViewModel(question: questionDetailViewModel)
    }
}

private extension QuestionDetailPresenter {

    func createViewModel(question: QuestionDetailViewModel) {
        DispatchQueue.main.async { [weak self] in
            self?.tableManager.update()
        }
    }
}
