import Foundation
import GetOfferCore

// MARK: - FavoriteItemPresenter
final class FavoriteItemPresenter {

    // MARK: - Public Properties
    weak var view: FavoriteItemViewInput?
    weak var storage: AudioPlayerUserDefaultsProtocol?
}

// MARK: - FavoriteItemViewDelegate
extension FavoriteItemPresenter: FavoriteItemViewDelegate {

    func viewDidLoad() {
        updateSwitches()
    }

    func changeAvailability(for group: AudioEventGroup, state: Bool) {
        storage?.setAudioEventGroupAvailability(group: group, state: state)
        updateSwitches()
    }
}

// MARK: - Private methods
private extension FavoriteItemPresenter {
    func updateSwitches() {
        guard
            let allSwitchState = storage?.audioEventGroupAvailability(group: .all),
            let paceSwitchState = storage?.audioEventGroupAvailability(group: .paceReached),
            let timeSwitchState = storage?.audioEventGroupAvailability(group: .percentageReached),
            let distanceSwitchState = storage?.audioEventGroupAvailability(group: .kilometerReached)
        else {
            print("Storage don't exist")
            return
        }
        guard let view = view else {
            print("View don't exist")
            return
        }
        view.updateSwitch(for: .all, with: allSwitchState)
        view.updateSwitch(for: .paceReached, with: paceSwitchState)
        view.updateSwitch(for: .percentageReached, with: timeSwitchState)
        view.updateSwitch(for: .kilometerReached, with: distanceSwitchState)
    }
}
