import Foundation

protocol QuestionDetailPresenterDelegate: AnyObject {
    func getDetailsCount() -> Int
    func getViewModelWith(indexPath: IndexPath) -> QuestionViewModel?
}
