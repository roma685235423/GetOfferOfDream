import UIKit
import GetOfferUI

final class QuestionDetailSegmentCell: UITableViewCell {

    // MARK: - Private Properties
    private let upperTextLabel: UILabel = {
        let label = UILabel()
        label.font = .headlineRegular
        label.textColor = .blackDynamic
        label.numberOfLines = 0
        return label
    }()

    private let urlLabel: UILabel = {
        let label = UILabel()
        label.font = .captionRegular
        label.textColor = .blackDynamic
        label.numberOfLines = 0
        return label
    }()

    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.addSubviews([upperTextLabel, urlLabel])
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Public Methods
extension QuestionDetailSegmentCell {

    func configure(with model: QuestionDetailSectionModel) {
        upperTextLabel.text = model.text
        urlLabel.text = model.imageURLString
    }
}

// MARK: - Private Methods
private extension QuestionDetailSegmentCell {

    func setConstraints() {
        NSLayoutConstraint.activate([
            upperTextLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            upperTextLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            upperTextLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constansts.verticalIndent/2),

            urlLabel.topAnchor.constraint(equalTo: upperTextLabel.bottomAnchor, constant: Constansts.verticalIndent/2),
            urlLabel.leftAnchor.constraint(equalTo: upperTextLabel.leftAnchor),
            urlLabel.rightAnchor.constraint(equalTo: upperTextLabel.rightAnchor),
            urlLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constansts.verticalIndent/2)
        ])
    }
}
