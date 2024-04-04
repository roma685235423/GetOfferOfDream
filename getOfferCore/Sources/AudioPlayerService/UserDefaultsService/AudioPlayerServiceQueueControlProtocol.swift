import Foundation

/**
 Протокол для взаимодействия с очередью воспроизведения аудио-событий.

 Этот протокол определяет метод для удаления аудио-событий из очереди воспроизведения.
 */
public protocol AudioPlayerServiceQueueControlProtocol: AnyObject {

    /**
     Удаляет аудио-события из очереди воспроизведения, принадлежащие указанной группе.

     - Parameter group: Группа аудио-событий, которые требуется удалить из очереди.

     # Пример использования
     ```
     audioService.removeEventsFromQueue(group: .percentageReached)
     ```
     */
    func removeEventsFromQueue(group: AudioEventGroup)
}
