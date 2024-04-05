import Foundation

/**
 Протокол `AudioPlayerUserDefaultsProtocol` определяет методы для работы с UserDefaults, связанными с
 доступностью групп аудио-событий.

 Этот протокол позволяет устанавливать и получать состояние доступности групп аудио-событий в UserDefaults.
 Используется в AudioPlayerService

 # Методы
 - `setAudioEventGroupAvailability(group:state:)`: Устанавливает доступность указанной группы аудио-событий.
 - `audioEventGroupAvailability(group:)`: Получает состояние доступности указанной группы аудио-событий.
 */
public protocol AudioPlayerUserDefaultsProtocol: AnyObject {

    /**
     Устанавливает доступность указанной группы аудио-событий.

     - Parameters:
     - group: Группа аудио-событий.
     - state: Состояние доступности (true - доступно, false - недоступно).
     */
    func setAudioEventGroupAvailability(group: AudioEventGroup, state: Bool)

    /**
     Получает состояние доступности указанной группы аудио-событий.

     - Parameter group: Группа аудио-событий.
     - Returns: `true`, если группа доступна, `false` в противном случае.
     */
    func audioEventGroupAvailability(group: AudioEventGroup) -> Bool
}
