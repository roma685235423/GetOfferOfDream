import Foundation

struct ThemeViewModel: ViewModel {
    let title: String
    let questions: [QuestionModel]
    let didTap: ([QuestionModel]) -> Void
}
