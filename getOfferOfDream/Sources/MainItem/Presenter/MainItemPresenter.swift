import Foundation
import GetOfferCore

final class MainItemPresenter {

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
