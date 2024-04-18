import Foundation

protocol MainItemPresenterDelegate: AnyObject {
    func getViewModelsCount() -> Int
    func getViewModelWith(indexPath: IndexPath) -> ThemeViewModel?
}
