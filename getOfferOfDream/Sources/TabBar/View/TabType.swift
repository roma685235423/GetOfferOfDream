import Foundation

// MARK: - TabType

enum TabType: String {
    case main = "book"
    case favorites = "bookmark"
    case quiz = "doc.questionmark"
    case feedback = "exclamationmark.bubble"
    case profile = "person"
}

// MARK: - Public methods

extension TabType {
    
    func selectedImageName() -> String {
        return self.rawValue + ".fill"
    }
    
    func normalImageName() -> String {
        return self.rawValue
    }
}
