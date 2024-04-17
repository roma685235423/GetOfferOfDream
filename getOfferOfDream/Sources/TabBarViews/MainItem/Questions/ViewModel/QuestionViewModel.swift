import Foundation

struct QuestionViewModel {
    let title: String
    let text: String
    let images: [String]

    let didTap: (QuestionViewModel) -> Void
}
