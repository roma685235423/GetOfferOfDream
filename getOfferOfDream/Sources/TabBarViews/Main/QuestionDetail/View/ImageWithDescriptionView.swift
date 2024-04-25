import UIKit
import GetOfferUI

final class ImageWithDescriptionView: UIView {

    // MARK: - Private Properties
    private let image: UIImageView = {
        let imageView = UIImageView()
        imageView.image = GetOfferOfDreamAsset.testImage1.image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .captionRegular
        label.textColor = .gray
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Рис. 1"
        return label
    }()

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubviews([image, descriptionLabel])
        self.layer.cornerRadius = Constants.cornerRadius
        self.layer.borderWidth = Constants.borderWidth
        self.layer.borderColor = UIColor.red.cgColor
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private Methods
private extension ImageWithDescriptionView {

    func setConstraints() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor, constant: Constants.verticalIndent),
            image.leftAnchor.constraint(equalTo: leftAnchor, constant: Constants.horizontalIndent),
            image.rightAnchor.constraint(equalTo: rightAnchor, constant: -Constants.horizontalIndent),
            image.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.verticalIndent * 2),

            descriptionLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: Constants.verticalIndent),
            descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            descriptionLabel.leftAnchor.constraint(equalTo: image.leftAnchor),
            descriptionLabel.rightAnchor.constraint(equalTo: image.rightAnchor),

            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
