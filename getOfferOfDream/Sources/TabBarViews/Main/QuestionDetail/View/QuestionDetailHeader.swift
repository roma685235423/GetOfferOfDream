import UIKit
import GetOfferUI

final class QuestionDetailHeader: UITableViewHeaderFooterView {

    // MARK: - Private Properties
    private let  questionTitle: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = .headlineSemibold
        label.numberOfLines = 0
        return label
    }()

    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()

    // MARK: - Initializers
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .whiteDynamic
        contentView.addSubviews([questionTitle, separatorView])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Public Methods
extension QuestionDetailHeader {
    func configure(with text: String) {
        questionTitle.text = text.uppercased()
    }
}

// MARK: - Private Methods
private extension QuestionDetailHeader {
    func setConstraints() {
        NSLayoutConstraint.activate([
            separatorView.topAnchor.constraint(
                equalTo: contentView.topAnchor
            ),
            separatorView.leftAnchor.constraint(
                equalTo: contentView.leftAnchor,
                constant: Constants.horizontalIndent
            ),
            separatorView.rightAnchor.constraint(
                equalTo: contentView.rightAnchor,
                constant: -Constants.horizontalIndent
            ),
            separatorView.heightAnchor.constraint(
                equalToConstant: Constants.separatorHeight
            ),

            questionTitle.topAnchor.constraint(
                equalTo: separatorView.bottomAnchor,
                constant: Constants.verticalIndent
            ),
            questionTitle.leftAnchor.constraint(
                equalTo: contentView.leftAnchor,
                constant: Constants.verticalIndent
            ),
            questionTitle.rightAnchor.constraint(
                equalTo: contentView.rightAnchor,
                constant: -Constants.verticalIndent
            ),
            questionTitle.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor
            )
        ])
    }
}
