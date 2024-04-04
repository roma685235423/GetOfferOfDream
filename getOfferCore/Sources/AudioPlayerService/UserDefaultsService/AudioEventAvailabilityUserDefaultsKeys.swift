import Foundation

/**
 Ключи, используемые для хранения доступности аудио-событий в UserDefaults.

 Эти ключи используются для сохранения состояния доступности различных групп аудио-событий в UserDefaults.
 Каждый ключ соответствует определенной группе аудио-событий, такой как события достижения километража, процентов или темпа.

 # Пример использования:
 ```
 let kilometerKey = AudioEventAvailabilityUserDefaultsKeys.kilometer
 let keyString = kilometerKey.string // "kilometerReachedEnabled"
 ```
 */
enum AudioEventAvailabilityUserDefaultsKeys {
    case kilometer
    case percentage
    case pace

    var string: String {
        switch self {
        case .kilometer:
            return "kilometerReachedEnabled"
        case .percentage:
            return "percentageReachedEnabled"
        case .pace:
            return "paceReachedEnabled"
        }
    }
}
