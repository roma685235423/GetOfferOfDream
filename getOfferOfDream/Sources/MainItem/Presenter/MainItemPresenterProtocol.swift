import Foundation

protocol MainItemPresenterProtocol: AnyObject {
    func getItemsCount() -> Int
    func getTitle(for indexPath: IndexPath) -> String
}
