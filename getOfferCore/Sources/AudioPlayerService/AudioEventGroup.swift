import Foundation

/**
 Группа аудио-событий, определяющая типы событий для воспроизведения звуковых файлов.

 Группа содержит следующие типы событий:
 - `all`: Все типы событий.
 - `kilometerReached`: События, связанные с достижением определенной дистанции.
 - `percentageReached`: События, связанные с достижением определенного процента выполнения.
 - `paceReached`: События, связанные с достижением определенного темпа.

 Каждая группа имеет свой приоритет, который определяет порядок воспроизведения событий.

 # Пример использования
 ```
 let group: AudioEventGroup = .kilometerReached
 let priority = group.priority()
 ```
 - Note: Метод `priority()` возвращает целочисленное значение, представляющее приоритет группы.
 */
public enum AudioEventGroup {
    case all
    case kilometerReached
    case percentageReached
    case paceReached

    public func priority() -> Int {
        switch self {
        case .all:
            return 0
        case .kilometerReached:
            return 1
        case .percentageReached:
            return 2
        case .paceReached:
            return 3
        }
    }
}
