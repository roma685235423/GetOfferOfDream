import Foundation

public protocol AudioPlayerServiceQueueControlProtocol: AnyObject {
    func removeEventsFromQueue(group: AudioEventGroup)
}

public final class AudioPlayerUserDefaultsService {

    // MARK: - Public Properties
    public weak var audioService: AudioPlayerServiceQueueControlProtocol?

    // MARK: - Private Properties
    private let storage = UserDefaults.standard

    public init() {}
}

extension AudioPlayerUserDefaultsService: AudioPlayerUserDefaultsProtocol {
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
     audioService.setAudioEventGroupAvailability(group: .kilometerReached, state: true)
     ```
     */
    public func setAudioEventGroupAvailability(group: AudioEventGroup, state: Bool) {
        switch group {
        case .all:
            storage.set(state, forKey: AudioEventAvailabilityUserDefaultsKeys.kilometer.string)
            storage.set(state, forKey: AudioEventAvailabilityUserDefaultsKeys.percentage.string)
            storage.set(state, forKey: AudioEventAvailabilityUserDefaultsKeys.pace.string)
            if !state { audioService?.removeEventsFromQueue(group: .all) }
        case .kilometerReached:
            storage.set(state, forKey: AudioEventAvailabilityUserDefaultsKeys.kilometer.string)
        case .percentageReached:
            storage.set(state, forKey: AudioEventAvailabilityUserDefaultsKeys.percentage.string)
        case .paceReached:
            storage.set(state, forKey: AudioEventAvailabilityUserDefaultsKeys.pace.string)
        }

        if !state && group != .all {
            audioService?.removeEventsFromQueue(group: group)
        }
    }

    /**
     Получает состояние доступности указанной группы аудио-событий.

     - Parameter group: Группа аудио-событий, для которой требуется получить состояние доступности.

     - Returns: Булево значение, указывающее состояние доступности указанной группы.

     # Пример использования
     ```
     let audioService = AudioPlayerService.shared
     let isGroupAvailable = audioService.audioEventGroupAvailability(group: .percentageReached)
     ```
     - Note: Если группа `.all`, то возвращается true только в том случае, если все группы включены.

     */
    public func audioEventGroupAvailability(group: AudioEventGroup) -> Bool {
        var result = false
        switch group {
        case .kilometerReached:
            result = storage.bool(forKey: AudioEventAvailabilityUserDefaultsKeys.kilometer.string)
        case .paceReached:
            result = storage.bool(forKey: AudioEventAvailabilityUserDefaultsKeys.pace.string)
        case .percentageReached:
            result = storage.bool(forKey: AudioEventAvailabilityUserDefaultsKeys.percentage.string)
        case .all:
            result = storage.bool(forKey: AudioEventAvailabilityUserDefaultsKeys.kilometer.string) &&
                storage.bool(forKey: AudioEventAvailabilityUserDefaultsKeys.pace.string) &&
                storage.bool(forKey: AudioEventAvailabilityUserDefaultsKeys.percentage.string)
        }
        return result
    }
}
