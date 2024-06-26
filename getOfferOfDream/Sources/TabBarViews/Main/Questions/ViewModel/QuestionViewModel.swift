import Foundation

struct QuestionViewModel: ViewModel {
    let title: String
    let sections: [QuestionDetailSectionModel]
    let didTap: (QuestionDetailViewModel) -> Void
}
