import Foundation
import GetOfferCore

protocol FavoriteItemViewInput: AnyObject {
    func updateSwitch(for group: AudioEventGroup, with state: Bool)
}
