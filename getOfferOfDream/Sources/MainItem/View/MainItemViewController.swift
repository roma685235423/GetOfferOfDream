import UIKit
import GetOfferUI

// MARK: - MainItemViewController
class MainItemViewController: UIViewController {

    // MARK: - Public Properties
    let tableView = UITableView(frame: .zero, style: .plain)

    // MARK: - Private Properties
    private let presenter: MainItemViewDelegate

    private let playPaceSoundButton = UIButton.withStandardConfiguration(title: "Темп")
    private let playTimeSoundButton = UIButton.withStandardConfiguration(title: "Время")
    private let playDistanceSoundButton = UIButton.withStandardConfiguration(title: "Дистанция")

    // MARK: - Initializers
    init(presenter: MainItemViewDelegate) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Overrides Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .opaqueSeparator
        view.addSubviews([playPaceSoundButton, playTimeSoundButton, playDistanceSoundButton, tableView])
        setConstraints()
        playPaceSoundButton.addTarget(self, action: #selector(playPaceSound), for: .touchUpInside)
        playTimeSoundButton.addTarget(self, action: #selector(playTimeSound), for: .touchUpInside)
        playDistanceSoundButton.addTarget(self, action: #selector(playDistanceSound), for: .touchUpInside)
    }

}

// MARK: - Private Methods
private extension MainItemViewController {

    func setConstraints() {
        let screenWidth = UIScreen.main.bounds.width
        let buttonWidth = GetOfferUI.calculateEqualWidth(forViewWidth: screenWidth, numberOfElements: 3)

        NSLayoutConstraint.activate([
            playPaceSoundButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Constansts.horizontalIndent),
            playPaceSoundButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            playPaceSoundButton.widthAnchor.constraint(equalToConstant: buttonWidth),

            playTimeSoundButton.leftAnchor.constraint(equalTo: playPaceSoundButton.rightAnchor,
                                                      constant: Constansts.horizontalIndent),
            playTimeSoundButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            playTimeSoundButton.widthAnchor.constraint(equalToConstant: buttonWidth),

            playDistanceSoundButton.leftAnchor.constraint(equalTo: playTimeSoundButton.rightAnchor,
                                                          constant: Constansts.horizontalIndent),
            playDistanceSoundButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            playDistanceSoundButton.widthAnchor.constraint(equalToConstant: buttonWidth),

            tableView.leftAnchor.constraint(equalTo: playPaceSoundButton.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: playDistanceSoundButton.rightAnchor),
            tableView.topAnchor.constraint(equalTo: playPaceSoundButton.bottomAnchor,
                                           constant: Constansts.verticalIndent),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    @objc private func playPaceSound() {
        presenter.playPaceSound()
    }

    @objc private func playTimeSound() {
        presenter.playTimeSound()
    }

    @objc private func playDistanceSound() {
        presenter.playDistanceSound()
    }
}
