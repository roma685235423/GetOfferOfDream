import Foundation
import AVFoundation

// MARK: - AudioPlayerService
/**
 Сервис воспроизведения аудио файлов.

 Этот сервис предоставляет функционал для воспроизведения аудио файлов в приложении.
 Он позволяет добавлять аудио события в очередь воспроизведения с учетом их приоритета и времени добавления.

 - Attention: **Важно!** Все звуковые файлы должны находиться в ресурсах приложения
 и быть предварительно загружены в приложение.

 - Warning: Переименование звуковых файлов **СТРОГО ЗАПРЕЩЕНО**

 # Использование
 Для использования сервиса необходимо создать экземпляр класса, реализующего протокол `AudioPlayerServiceProtocol`.

 # Автоматическое воспроизведение

 Сервис автоматически переходит к следующему аудио файлу из очереди после завершения воспроизведения текущего файла.
 Это позволяет воспроизводить аудио файлы последовательно без необходимости вмешательства извне.

 # Приоритет событий

 Каждое аудио событие имеет свой приоритет. При добавлении нового события в очередь,
 оно помещается в соответствующее место в очереди с учетом приоритета.
 Более приоритетные события воспроизводятся раньше, чем менее приоритетные.

 # Отслеживание очереди

 Очередь воспроизведения можно отслеживать при необходимости, реализуя протокол `AudioPlayerServiceDelegate`.
 Этот протокол определяет метод `audioPlayerService(didUpdateQueue:)`,
 который вызывается при обновлении очереди воспроизведения.

 # Пример использования в презентере целевого экрана с свитчами управления категориями оповещений.
 ```
 final class SettingsPresenter {

 // MARK: - Public Properties
 weak var view: FavoriteItemViewInput?
 weak var storage: AudioPlayerUserDefaultsProtocol?
 }

 // MARK: - FavoriteItemViewDelegate
 extension TargetPresenter: FavoriteItemViewDelegate {

 func viewDidLoad() {
 updateSwitches()
 }

 func changeAvailability(for group: AudioEventGroup, state: Bool) {
 storage?.setAudioEventGroupAvailability(group: group, state: state)
 updateSwitches()
 }
 }

 // MARK: - Private methods
 private extension SettingsPresenter {
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
 }
 ```

 # Пример использования метода обновления состояния свитча в расширении контроллера представления
 ```
 extension SettingsViewController: SettingsViewProtocol {

 func updateSwitch(for group: AudioEventGroup, with state: Bool) {
 switch group {
 case .all:
 paceCategoryAvailabilitySwitch.setOn(state, animated: true)
 timeCategoryAvailabilitySwitch.setOn(state, animated: true)
 distanceCategoryAvailabilitySwitch.setOn(state, animated: true)
 allCategoryAvailabilitySwitch.setOn(state, animated: true)
 case .kilometerReached:
 distanceCategoryAvailabilitySwitch.setOn(state, animated: true)
 case .paceReached:
 paceCategoryAvailabilitySwitch.setOn(state, animated: true)
 case .percentageReached:
 timeCategoryAvailabilitySwitch.setOn(state, animated: true)
 }
 }
 ```
 */
public final class AudioPlayerService: NSObject {

    // MARK: - Public Properties
    public weak var delegate: AudioPlayerServiceDelegate?

    // MARK: - Private Properties
    private var player: AVAudioPlayer?
    private var eventQueue: [AudioEventType] = [] {
        didSet {
            delegate?.audioPlayerService(didUpdateQueue: eventQueue)
        }
    }
    private let storage: AudioPlayerUserDefaultsProtocol

    // MARK: - Initializers
    public init(storage: AudioPlayerUserDefaultsProtocol) {
        self.storage = storage
        super.init()
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Error playing audio: \(error.localizedDescription)")
        }
    }
}

// MARK: - Public Methods
extension AudioPlayerService: AudioPlayerServiceProtocol {

    /**
     Добавляет аудио событие в очередь воспроизведения и начинает его воспроизведение.

     Этот метод добавляет указанное аудио событие в очередь воспроизведения аудио файлов.
     Очередь управляется сервисом воспроизведения, и события воспроизводятся в
     порядке их добавления с учетом их приоритета.
     После добавления события в очередь, его воспроизведение начинается автоматически,
     если в данный момент не проигрывается другой аудио файл.

     - Parameter event: Аудио событие, которое необходимо добавить в очередь воспроизведения.
     Это экземпляр типа `AudioEventType`, описывающий конкретное аудио событие.

     # Пример использования в презентере целевого экрана

     ```
     final class TrainingPresenter {
     private let audioService: AudioPlayerServiceProtocol
     //...
     }

     extension MainItemPresenter: TrainingViewDelegate {

     func playPaceSound() {
     let paceEventType = AudioEventType.paceReached(10)
     audioService.playAudio(for: paceEventType)
     }
     //...
     }
     ```

     Этот код добавит событие о достижении дистанции 10 км в
     очередь воспроизведения аудио файлов и начнет его воспроизведение.
     */
    public func playAudio(for event: AudioEventType) {
        guard storage.audioEventGroupAvailability(group: event.toGroup()) else {
            print("Event group is disabled.")
            return
        }

        let fileName = event.audioFileName
        guard let fileURL = Bundle.main.url(forResource: fileName, withExtension: nil) else {
            print("Audio file \(fileName) not found")
            return
        }

        var insertIndex = eventQueue.count
        for (index, existingEvent) in eventQueue.enumerated() where event.priority() < existingEvent.priority() {
            insertIndex = index
            break
        }
        eventQueue.insert(event, at: insertIndex)

        guard player == nil || !player!.isPlaying else { return }
        play(fileURL: fileURL)
    }
}

// MARK: - AVAudioPlayerDelegate
extension AudioPlayerService: AVAudioPlayerDelegate {

    public func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        guard let nextEvent = eventQueue.first else { return }

        if let fileURL = Bundle.main.url(forResource: nextEvent.audioFileName, withExtension: nil) {
            play(fileURL: fileURL)
        }
    }
}

// MARK: - AudioPlayerServiceQueueControlProtocol
extension AudioPlayerService: AudioPlayerServiceQueueControlProtocol {

    public func removeEventsFromQueue(group: AudioEventGroup) {
        switch group {
        case .all:
            eventQueue.removeAll()
        default:
            eventQueue = eventQueue.filter { $0.toGroup() != group }
        }
    }
}

// MARK: - Private Methods
private extension AudioPlayerService {

    func play(fileURL: URL) {
        do {
            self.player = try AVAudioPlayer(contentsOf: fileURL)
            self.player?.delegate = self
            self.player?.prepareToPlay()
            self.player?.play()
        } catch let error {
            print("Error playing audio: \(error.localizedDescription)")
        }
        eventQueue.removeFirst()
    }
}
