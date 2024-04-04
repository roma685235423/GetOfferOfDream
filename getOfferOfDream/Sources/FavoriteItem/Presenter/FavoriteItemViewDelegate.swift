import Foundation
import GetOfferCore

protocol FavoriteItemViewDelegate: AnyObject {
    func viewDidLoad()
    func changeAvailability(for: AudioEventGroup, state: Bool)
}
