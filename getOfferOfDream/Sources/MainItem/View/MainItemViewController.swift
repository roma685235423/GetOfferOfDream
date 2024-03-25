import UIKit
import GetOfferUI
import GetOfferCore

// MARK: - MainItemViewController
class MainItemViewController: UIViewController {

    private let playPaceSoundButton = UIButton.withStandardConfiguration(title: "Темп")
    private let playTimeSoundButton = UIButton.withStandardConfiguration(title: "Время")
    private let playDistanceSoundButton = UIButton.withStandardConfiguration(title: "Дистанция")

    // MARK: - Overrides Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .opaqueSeparator
        view.addSubviews([playPaceSoundButton, playTimeSoundButton, playDistanceSoundButton])
        setConstraints()
    }

}

// MARK: - Private Methods
private extension MainItemViewController {

    func setConstraints() {
        let screenWidth = UIScreen.main.bounds.width
        let buttonWidth = GetOfferUI.calculateEqualWidth(forViewWidth: screenWidth, numberOfElements: 3)

        NSLayoutConstraint.activate([
            playPaceSoundButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Constansts.horizontalIndent),
            playPaceSoundButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            playPaceSoundButton.widthAnchor.constraint(equalToConstant: buttonWidth),

            playTimeSoundButton.leftAnchor.constraint(equalTo: playPaceSoundButton.rightAnchor,
                                                      constant: Constansts.horizontalIndent),
            playTimeSoundButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            playTimeSoundButton.widthAnchor.constraint(equalToConstant: buttonWidth),

            playDistanceSoundButton.leftAnchor.constraint(equalTo: playTimeSoundButton.rightAnchor,
                                                          constant: Constansts.horizontalIndent),
            playDistanceSoundButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            playDistanceSoundButton.widthAnchor.constraint(equalToConstant: buttonWidth)
        ])
    }
}
