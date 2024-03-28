import Foundation
import GetOfferCore

final class MainItemPresenter {

    weak var view: MainItemViewInput?

    // MARK: - Private Properties
    private let tableManager: MainTableManagerProtocol
    private var playerFilesQueue: [String] = [] {
        didSet {
            tableManager.updateTable()
        }
    }

    // MARK: - Initializers
    init(tableManager: MainTableManagerProtocol) {
        self.tableManager = tableManager
        AudioPlayerService.shared.delegate = self
    }
}

// MARK: - MainItemViewDelegate
extension MainItemPresenter: MainItemViewDelegate {

    func viewDidLoad() {
        updateSwitches()
    }

    func changePaceCategoryAvaliability(to state: Bool) {
        AudioPlayerService.shared.setAudioEventGroupAvaliability(group: .paceReached, state: state)
        updateSwitches()
    }

    func changeTimeCategoryAvaliability(to state: Bool) {
        AudioPlayerService.shared.setAudioEventGroupAvaliability(group: .percentageReached, state: state)
        updateSwitches()
    }

    func changeDistanceCategoryAvaliability(to state: Bool) {
        AudioPlayerService.shared.setAudioEventGroupAvaliability(group: .kilometerReached, state: state)
        updateSwitches()
    }

    func changeAllCategoryAvaliability(to state: Bool) {
        AudioPlayerService.shared.setAudioEventGroupAvaliability(group: .all, state: state)
        updateSwitches()
    }

    func playPaceSound() {
        let paceEventType = AudioEventType.paceReached(Int.random(in: 1...15))
        AudioPlayerService.shared.playAudio(for: paceEventType)
    }

    func playTimeSound() {
        let paceEventType = AudioEventType.percentageReached((Int.random(in: 25...124)/25)*25)
        AudioPlayerService.shared.playAudio(for: paceEventType)
    }

    func playDistanceSound() {
        let paceEventType = AudioEventType.kilometerReached(Int.random(in: 1...13))
        AudioPlayerService.shared.playAudio(for: paceEventType)
    }
}

// MARK: - AudioPlayerServiceDelegate
extension MainItemPresenter: AudioPlayerServiceDelegate {
    func audioEventGroupFeedback(group: AudioEventGroup, state: Bool) {

    }

    func audioPlayerService(didUpdateQueue eventQueue: [AudioEventType]) {
        playerFilesQueue = eventQueue.map {$0.audioFileName}
    }
}

// MARK: - MainItemPresenterProtocol
extension MainItemPresenter: MainItemPresenterProtocol {
    func getTitle(for indexPath: IndexPath) -> String {
        return playerFilesQueue[indexPath.item]
    }

    func getItemsCount() -> Int {
        playerFilesQueue.count
    }
}

private extension MainItemPresenter {
    func updateSwitches() {
        let allSwitchState = AudioPlayerService.shared.audioEventGroupAvaliability(group: .all)
        let paceSwitchState = AudioPlayerService.shared.audioEventGroupAvaliability(group: .paceReached)
        let timeSwitchState = AudioPlayerService.shared.audioEventGroupAvaliability(group: .percentageReached)
        let distanceSwitchState = AudioPlayerService.shared.audioEventGroupAvaliability(group: .kilometerReached)

        view?.updateAllSwitch(with: allSwitchState)
        view?.updatePaceSwitch(with: paceSwitchState)
        view?.updateTimeSwitch(with: timeSwitchState)
        view?.updateDistanceSwitch(with: distanceSwitchState)
    }
}
