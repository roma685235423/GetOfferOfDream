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

    private let image: UIImageView = {
        let imageView = UIImageView()
        imageView.image = GetOfferOfDreamAsset.testImage1.image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.addSubviews([upperTextLabel])
        setConstraints(withImage: false)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        upperTextLabel.text = ""
        image.removeFromSuperview()
    }
}

// MARK: - Public Methods
extension QuestionDetailSegmentCell {

    func configure(with model: QuestionDetailSectionModel) {
        upperTextLabel.text = model.text
        let isNeedImage = model.imageURLString == nil ? false : true
        setConstraints(withImage: isNeedImage)
        layoutIfNeeded()
    }
}

// MARK: - Private Methods
private extension QuestionDetailSegmentCell {

    func setConstraints(withImage: Bool) {
        contentView.removeConstraints(contentView.constraints)

        if !withImage {
            NSLayoutConstraint.activate([
                upperTextLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
                upperTextLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
                upperTextLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
                upperTextLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
        } else {
            contentView.addSubviews([image])
            NSLayoutConstraint.activate([
                upperTextLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
                upperTextLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
                upperTextLabel.topAnchor.constraint(
                    equalTo: contentView.topAnchor,
                    constant: Constants.verticalIndent/2
                ),

                image.topAnchor.constraint(
                    equalTo: upperTextLabel.bottomAnchor,
                    constant: Constants.verticalIndent/2
                ),
                image.leftAnchor.constraint(equalTo: upperTextLabel.leftAnchor),
                image.rightAnchor.constraint(equalTo: upperTextLabel.rightAnchor),
                image.bottomAnchor.constraint(
                    equalTo: contentView.bottomAnchor,
                    constant: -Constants.verticalIndent/2
                )
            ])
        }
    }
}
