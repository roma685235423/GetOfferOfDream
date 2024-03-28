import Foundation

/**
 Определяет тип аудио события для воспроизведения.

 AudioEventType содержит три возможных вида аудио событий:

 > AudioEventType содержит три возможных вида аудио событий:
 >- достижение определенной дистанции .kilometerReached
 >- процентного завершения тренировки .percentageReached
 >- достижение определенного темпа .paceReached

 Каждый тип аудио события связан с соответствующиим типом звуковых файлов для воспроизведения.

 - Attention: **Важно!** Все звуковые файлы должны находиться в ресурсах приложения
 и быть предварительно загружены в приложение.

 - Warning: Переименование звуковых файлов **СТРОГО ЗАПРЕЩЕНО**

 # Примеры использования:
 ```
 let event1 = AudioEventType.kilometerReached(5)
 let event2 = AudioEventType.percentageReached(50)
 let event3 = AudioEventType.paceReached(8)
 ```

 В этих примерах определены различные типы аудио событий:
 - достижение 5-километровой дистанции
 - завершение тренировки на 50%
 - достижение темпа 8 км/час.
 */
public enum AudioEventType {
    case kilometerReached(Int)
    case percentageReached(Int)
    case paceReached(Int)

    public var audioFileName: String {
        switch self {
        case .kilometerReached(let kilometer):
            return "distance_\(kilometer)_km.wav"
        case .percentageReached(let percentage):
            return "time_workoutCompleted_\(percentage).wav"
        case .paceReached(let pace):
            return "pace_\(pace)_kmh.wav"
        }
    }

    public func priority() -> Int {
        switch self {
        case .kilometerReached:
            return 1
        case .percentageReached:
            return 2
        case .paceReached:
            return 3
        }
    }
}
