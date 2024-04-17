import Foundation

protocol QuestionPresenterDelegate: AnyObject {
    func getViewModelsCount() -> Int
    func getViewModelWith(indexPath: IndexPath) -> QuestionViewModel?
}
