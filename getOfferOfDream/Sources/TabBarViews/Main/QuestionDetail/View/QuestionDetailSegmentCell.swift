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

    private let pictureView: UIImageView = {
        let imageView = UIImageView()
        imageView.sizeToFit()
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(origin: .zero, size: CGSize(width: 250, height: 250))
        imageView.clipsToBounds = true
        return imageView
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .headlineRegular
        label.textColor = .gray
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Рис. 1"
        return label
    }()

    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.addSubviews([upperTextLabel])
        setMainConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Overrides Methods
    override func prepareForReuse() {
        super.prepareForReuse()
        upperTextLabel.text = ""
        pictureView.removeFromSuperview()
        descriptionLabel.removeFromSuperview()
    }
}

// MARK: - Public Methods
extension QuestionDetailSegmentCell {

    func configure(with model: QuestionDetailSectionModel) {
        upperTextLabel.text = model.text
        layoutIfNeeded()
    }

    func setImage(image: UIImage) {
        pictureView.image = image
        let imageSize = image.size
        let aspectRatio = imageSize.width / imageSize.height
        let newWidth = contentView.bounds.width
        let newHeight = newWidth / aspectRatio
        pictureView.frame.size = CGSize(width: newWidth, height: newHeight)
        setConstraintsWithImage()
    }
}

// MARK: - Private Methods
private extension QuestionDetailSegmentCell {

    func setMainConstraints() {
        contentView.removeConstraints(contentView.constraints)

        NSLayoutConstraint.activate([
            upperTextLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            upperTextLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            upperTextLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            upperTextLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    func setConstraintsWithImage() {
        contentView.removeConstraints(contentView.constraints)
        contentView.addSubviews([pictureView, descriptionLabel])

        NSLayoutConstraint.activate([
            upperTextLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            upperTextLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            upperTextLabel.topAnchor.constraint(equalTo: contentView.topAnchor),

            pictureView.leftAnchor.constraint(greaterThanOrEqualTo: upperTextLabel.leftAnchor),
            pictureView.rightAnchor.constraint(lessThanOrEqualTo: upperTextLabel.rightAnchor),
            pictureView.topAnchor.constraint(equalTo: upperTextLabel.bottomAnchor,
                                             constant: Constants.verticalIndent),
            pictureView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            pictureView.heightAnchor.constraint(equalToConstant: pictureView.frame.size.height),

            descriptionLabel.leftAnchor.constraint(equalTo: pictureView.leftAnchor),
            descriptionLabel.rightAnchor.constraint(equalTo: pictureView.rightAnchor),
            descriptionLabel.topAnchor.constraint(
                equalTo: pictureView.bottomAnchor,
                constant: Constants.verticalIndent / 2
            ),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
