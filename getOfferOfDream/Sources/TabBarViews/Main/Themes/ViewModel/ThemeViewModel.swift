import Foundation

struct ThemeViewModel: ViewModel {
    let theme: ThemeModel
    let didTap: ([QuestionModel]) -> Void
}
