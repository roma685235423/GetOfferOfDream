import Foundation

struct ThemeViewModel {
    let title: String
    let questions: [QuestionModel]
    let didTap: ([QuestionModel]) -> Void
}
