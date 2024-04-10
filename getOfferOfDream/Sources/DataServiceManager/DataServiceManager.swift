import Foundation

struct DataServiceManager {
    static var shared = DataServiceManager()

    let themes = [ThemeModel(
        title: "Архитектуры и паттерны",
        questions: [
            QuestionModel(
                title: "Виды паттернов проектирования",
                text:
                    """
Delegate Pattern
Позволяет объектам делегировать определенные задачи другим объектам для выполнения.
В iOS используется, например, для обработки событий и управления жизненным циклом элементов интерфейса.
""",
                images: []
            ),
            QuestionModel(
                title: "Виды архитектур проектирования",
                text:
                    """
Model-View-Controller (MVC)
Это классическая архитектура, которая разделяет приложение на три компонента:
модель (хранит данные и бизнес-логику),
вид (отображает данные пользователю) и контроллер (управляет взаимодействием между моделью и видом).
MVC является стандартным подходом для iOS-разработки и широко используется Apple.
""",
                images: []
            )
        ]
    ),
    ThemeModel(
        title: "Базовые понятия в it",
        questions: [
            QuestionModel(
                title: "REST API",
                text: ".whegfkugewiygf",
                images: []
            ),
            QuestionModel(
                title: "http",
                text: "lkjjbj",
                images: []
            )
        ]
    )
    ]
}
