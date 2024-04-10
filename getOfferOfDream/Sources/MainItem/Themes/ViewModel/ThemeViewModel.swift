import Foundation

struct ThemeViewModel {
    let title: String
    let questions: [QuestionViewModel]
    let didTap: ([QuestionViewModel]) -> Void
}
