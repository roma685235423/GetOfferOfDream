import Foundation
import GetOfferCore

final class MainItemPresenter {

    // MARK: - Public Properties
    weak var view: MainItemViewInput?

    // MARK: - Private Properties
    private let tableManager: MainTableManagerProtocol
    private let audioService: AudioPlayerServiceProtocol
    private var playerFilesQueue: [String] = [] {
        didSet {
            tableManager.updateTable()
        }
    }

    // MARK: - Initializers
    init(tableManager: MainTableManagerProtocol) {
        self.tableManager = tableManager
        self.audioService = AudioPlayerService()
        self.audioService.delegate = self
    }
}

// MARK: - MainItemViewDelegate
extension MainItemPresenter: MainItemViewDelegate {

    func viewDidLoad() {
        updateSwitches()
    }

    func changePaceCategoryAvailability(to state: Bool) {
        audioService.setAudioEventGroupAvailability(group: .paceReached, state: state)
        updateSwitches()
    }

    func changeTimeCategoryAvailability(to state: Bool) {
        audioService.setAudioEventGroupAvailability(group: .percentageReached, state: state)
        updateSwitches()
    }

    func changeDistanceCategoryAvailability(to state: Bool) {
        audioService.setAudioEventGroupAvailability(group: .kilometerReached, state: state)
        updateSwitches()
    }

    func changeAllCategoryAvailability(to state: Bool) {
        audioService.setAudioEventGroupAvailability(group: .all, state: state)
        updateSwitches()
    }

    func playPaceSound() {
        let paceEventType = AudioEventType.paceReached(Int.random(in: 1...15))
        audioService.playAudio(for: paceEventType)
    }

    func playTimeSound() {
        let paceEventType = AudioEventType.percentageReached((Int.random(in: 25...124)/25)*25)
        audioService.playAudio(for: paceEventType)
    }

    func playDistanceSound() {
        let paceEventType = AudioEventType.kilometerReached(Int.random(in: 1...13))
        audioService.playAudio(for: paceEventType)
    }
}

// MARK: - AudioPlayerServiceDelegate
extension MainItemPresenter: AudioPlayerServiceDelegate {
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
        let allSwitchState = audioService.audioEventGroupAvailability(group: .all)
        let paceSwitchState = audioService.audioEventGroupAvailability(group: .paceReached)
        let timeSwitchState = audioService.audioEventGroupAvailability(group: .percentageReached)
        let distanceSwitchState = audioService.audioEventGroupAvailability(group: .kilometerReached)

        view?.updateAllSwitch(with: allSwitchState)
        view?.updatePaceSwitch(with: paceSwitchState)
        view?.updateTimeSwitch(with: timeSwitchState)
        view?.updateDistanceSwitch(with: distanceSwitchState)
    }
}
