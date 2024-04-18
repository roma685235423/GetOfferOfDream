import Foundation

protocol BaseTablePresenterDelegate: AnyObject {
    func getViewModelsCount() -> Int
    func getViewModelWith<T: ViewModel>(indexPath: IndexPath) -> T?
}
