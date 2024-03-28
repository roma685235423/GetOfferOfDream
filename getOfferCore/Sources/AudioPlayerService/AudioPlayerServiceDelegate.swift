import Foundation

/**
 Протокол делегата для обратной связи от сервиса воспроизведения аудио.

 Данный протокол определяет методы, которые должен реализовать делегат для получения
 обновлений от сервиса воспроизведения аудио.

 # Пример использования
 ```
 class MyAudioPlayerDelegate: AudioPlayerServiceDelegate {
 func audioPlayerService(didUpdateQueue eventQueue: [AudioEventType]) {
 // Обработка обновления очереди воспроизведения аудио
 }
 }
 ```

 - Note: Реализация метода `audioPlayerService(didUpdateQueue:)` позволяет получать обновления
 очереди воспроизведения аудио событий. Метод `audioEventGroupFeedback(group:state:)` предоставляет
 обратную связь о состоянии определенной группы аудио событий.
 */

public protocol AudioPlayerServiceDelegate: AnyObject {
    func audioPlayerService(didUpdateQueue eventQueue: [AudioEventType])
}
