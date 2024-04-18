import Foundation

struct DataServiceManager {
    static var shared = DataServiceManager()

    let themes = [
        ThemeModel(
            title: "Архитектуры и паттерны",
            questions: [
                QuestionModel(
                    title: "Виды паттернов проектирования",
                    sections: [
                        QuestionDetailSectionModel(
                            text: """
                            Delegate Pattern
                            Позволяет объектам делегировать определенные задачи другим объектам для выполнения.
                            """,
                            imageURLString: "Картинка 1"
                        ),
                        QuestionDetailSectionModel(
                            text: """
                            В iOS используется, например, для обработки событий и
                            управления жизненным циклом элементов интерфейса.
                            """,
                            imageURLString: "Картинка 2"
                        )

                    ]
                ),
                QuestionModel(
                    title: "Виды архитектур проектирования",
                    sections: [
                        QuestionDetailSectionModel(
                            text: """
                            Model-View-Controller (MVC)
                            Это классическая архитектура, которая разделяет приложение на три компонента:
                            модель (хранит данные и бизнес-логику),
                            """,
                            imageURLString: "Картинка 1"
                        ),
                        QuestionDetailSectionModel(
                            text: """
                            вид (отображает данные пользователю) и контроллер
                            (управляет взаимодействием между моделью и видом).
                            MVC является стандартным подходом для iOS-разработки и широко используется Apple.
                            """
                            ,
                            imageURLString: "Картинка 2"
                        )
                    ]
                )
            ]
        ),
        ThemeModel(
            title: "Многопоточность",
            questions: [
                QuestionModel(
                    title: "Grand Central Dispatch (GCD)",
                    sections: [
                        QuestionDetailSectionModel(
                            text: """
                                Dispatch, больше известный как GCD – фреймворк, содержащий в себе языковые конструкции,
                                позволяющие нам комфортно и достаточно просто управлять потоками,
                                задачами для выполнения и ресурсами,
                                которые нам необходимо захватить.
                                GCD работает на системном уровне, таким образом он может удовлетворить
                                потребности всех запущенных приложений на девайсе, при этом управляя ресурсами эффективно.
                                """,
                            imageURLString: "Картинка 1"
                        ),
                        QuestionDetailSectionModel(
                            text: """
                                GCD реализован на языке `C`, поэтому фактически является низкоуровневым фреймворком.
                                Однако начиная со Swift 3.0 обзавелся читаемым Swift API.
                                GCD поддерживается как в iOS, так и в macOS, watchOS и tvOS
                                """,
                            imageURLString: "Картинка 2"
                        )

                    ]
                ),
                QuestionModel(
                    title: "Queue (очередь)",
                    sections: [
                        QuestionDetailSectionModel(
                            text: """
                                Очередь представляет собой сущность, выполняющую задачи, поступающие на вход
                                на одном или множестве потоков. Представьте себе очередь на кассу в любом продуктовом магазине.
                                В данном случае касса, которая вас обслужит – это поток,
                                вы – сама задача, а все вместе – очередь.
                                """,
                            imageURLString: "Картинка 1"
                        ),
                        QuestionDetailSectionModel(
                            text: """
                                Очередь работает по принципу [FIFO](https://ru.wikipedia.org/wiki/FIFO),
                                таким образом первая задача на очереди будет первой направлена на выполнение на потоке.
                                """,
                            imageURLString: "Картинка 2"
                        )
                    ]
                )
            ]
        )
    ]
}
