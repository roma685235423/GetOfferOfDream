import Foundation
import AVFoundation

// MARK: - AudioPlayerService
/**
 Сервис воспроизведения аудио файлов.

 Данный сервис предоставляет функционал для воспроизведения аудио файлов в приложении.
 Он позволяет добавлять аудио события в очередь воспроизведения с учетом их приоритета и времени добавления.

 - Attention: **Важно!** Все звуковые файлы должны находиться в ресурсах приложения
 и быть предварительно загружены в приложение.

 - Warning: Переименование звуковых файлов **СТРОГО ЗАПРЕЩЕНО**

 # Использование

 Для использования сервиса необходимо создать экземпляр класса `AudioPlayerService`, который является синглтоном.
 Далее, можно вызывать метод `playAudio(for:)`, передавая в него экземпляр типа `AudioEventType`,
 который описывает аудио событие.
 # Пример использования

 ```
 let audioService = AudioPlayerService.shared
 audioService.playAudio(for: .kilometerReached(10))
 ```
 Этот код добавит событие о достижении дистанции 10 км в очередь
 воспроизведения аудио файлов и начнет его воспроизведение.

 # Пример использования в презентере целевого экрана с свитчами управления категориями оповещений.
 ```
 func changePaceCategoryAvaliability(to state: Bool) {
 AudioPlayerService.shared.setAudioEventGroupAvaliability(group: .paceReached, state: state)
 updateSwitches()
 }

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

 ```
 # Пример использования метода обновления состояния свитча в раширении контроллера представления
 ```
 func updatePaceSwitch(with state: Bool) {
 paceCategoryAvaliabilitySwitch.setOn(state, animated: true)
 }
 ```

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
 ```
 extension YourClass: AudioPlayerServiceDelegate {
 func audioPlayerService(didUpdateQueue eventQueue: [AudioEventType]) {
 // Обработка обновления очереди
 }
 }
 ```
 */
public final class AudioPlayerService: NSObject {

    // MARK: - Public Properties
    public weak var delegate: AudioPlayerServiceDelegate?
    public static let shared = AudioPlayerService()

    // MARK: - Private Properties
    private var player: AVAudioPlayer?
    private var eventQueue: [AudioEventType] = [] {
        didSet {
            delegate?.audioPlayerService(didUpdateQueue: eventQueue)
        }
    }
    private let storage = UserDefaults.standard
    // UserDefaults Keys
    private let kilometerReachedEnabledKey = "kilometerReachedEnabled"
    private let percentageReachedEnabledKey = "percentageReachedEnabled"
    private let paceReachedEnabledKey = "paceReachedEnabled"

    // MARK: - Initializers
    override init() {
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
public extension AudioPlayerService {

    /**
     Добавляет аудио событие в очередь воспроизведения и начинает его воспроизведение.

     Этот метод добавляет указанное аудио событие в очередь воспроизведения аудио файлов.
     Очередь управляется сервисом воспроизведения, и события воспроизводятся в
     порядке их добавления с учетом их приоритета.
     После добавления события в очередь, его воспроизведение начинается автоматически,
     если в данный момент не проигрывается другой аудио файл.

     - Parameter event: Аудио событие, которое необходимо добавить в очередь воспроизведения.
     Это экземпляр типа `AudioEventType`, описывающий конкретное аудио событие.

     # Пример использования

     ```
     let audioService = AudioPlayerService.shared
     audioService.playAudio(for: .kilometerReached(10))
     ```

     Этот код добавит событие о достижении дистанции 10 км в
     очередь воспроизведения аудио файлов и начнет его воспроизведение.
     */
    func playAudio(for event: AudioEventType) {
        guard audioEventGroupAvaliability(group: event.toGroup()) else {
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

    /**
     Устанавливает доступность групп аудио-событий.

     - Parameters:
     - group: Группа аудио-событий, для которой устанавливается доступность.
     - state: Новое состояние доступности для указанной группы.

     При установке состояния группы в false, все события, принадлежащие этой группе, удаляются из очереди.

     - Note: Если группа равна `.all` и ее состояние установлено в false, вся очередь событий будет очищена.

     - Important: Этот метод обновляет значения UserDefaults, чтобы сохранить состояние групп аудио-событий.

     # Пример использования
     ```
     let audioService = AudioPlayerService.shared
     audioService.setAudioEventGroupAvaliability(group: .kilometerReached, state: true)
     ```
     */
    func setAudioEventGroupAvailability(group: AudioEventGroup, state: Bool) {
        switch group {
        case .all:
            storage.set(state, forKey: kilometerReachedEnabledKey)
            storage.set(state, forKey: percentageReachedEnabledKey)
            storage.set(state, forKey: paceReachedEnabledKey)
            if !state { eventQueue.removeAll() }
        case .kilometerReached:
            storage.set(state, forKey: kilometerReachedEnabledKey)
        case .percentageReached:
            storage.set(state, forKey: percentageReachedEnabledKey)
        case .paceReached:
            storage.set(state, forKey: paceReachedEnabledKey)
        }

        if !state && group != .all {
            removeEventsFromQueue(group: group)
        }
    }

    /**
     Получает состояние доступности указанной группы аудио-событий.

     - Parameter group: Группа аудио-событий, для которой требуется получить состояние доступности.

     - Returns: Булево значение, указывающее состояние доступности указанной группы.

     # Пример использования
     ```
     let audioService = AudioPlayerService.shared
     let isGroupAvailable = audioService.audioEventGroupAvaliability(group: .percentageReached)
     ```
     - Note: Если группа `.all`, то возвращается true только в том случае, если все группы включены.

     */
    func audioEventGroupAvaliability(group: AudioEventGroup) -> Bool {
        var result = false
        switch group {
        case .kilometerReached:
            result = storage.bool(forKey: kilometerReachedEnabledKey)
        case .paceReached:
            result = storage.bool(forKey: paceReachedEnabledKey)
        case .percentageReached:
            result = storage.bool(forKey: percentageReachedEnabledKey)
        case .all:
            result = storage.bool(forKey: kilometerReachedEnabledKey) &&
                storage.bool(forKey: paceReachedEnabledKey) &&
                storage.bool(forKey: percentageReachedEnabledKey)
        }
        return result
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

    func removeEventsFromQueue(group: AudioEventGroup) {
        eventQueue = eventQueue.filter { $0.toGroup() != group }
    }
}
