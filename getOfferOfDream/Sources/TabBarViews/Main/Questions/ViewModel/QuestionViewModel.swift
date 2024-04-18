import Foundation

struct QuestionViewModel {
    let title: String
    let sections: [QuestionDetailSectionModel]

    let didTap: (QuestionViewModel) -> Void
}
