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

    private let paceCategoryAvaliabilitySwitch = UISwitch()
    private let timeCategoryAvaliabilitySwitch = UISwitch()
    private let distanceCategoryAvaliabilitySwitch = UISwitch()
    private let allCategoryAvaliabilitySwitch = UISwitch()

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
        view.addSubviews([playPaceSoundButton, playTimeSoundButton, playDistanceSoundButton, tableView,
                          paceCategoryAvaliabilitySwitch, timeCategoryAvaliabilitySwitch,
                          distanceCategoryAvaliabilitySwitch, allCategoryAvaliabilitySwitch])
        setConstraints()
        presenter.viewDidLoad()
        playPaceSoundButton.addTarget(self, action: #selector(playPaceSound), for: .touchUpInside)
        playTimeSoundButton.addTarget(self, action: #selector(playTimeSound), for: .touchUpInside)
        playDistanceSoundButton.addTarget(self, action: #selector(playDistanceSound), for: .touchUpInside)
        paceCategoryAvaliabilitySwitch.addTarget(self,
                                                 action: #selector(changePaceCategoryAvaliability(_:)),
                                                 for: .valueChanged)
        timeCategoryAvaliabilitySwitch.addTarget(self,
                                                 action: #selector(changeTimeCategoryAvaliability(_:)),
                                                 for: .valueChanged)
        distanceCategoryAvaliabilitySwitch.addTarget(self,
                                                     action: #selector(changeDistanceCategoryAvaliability(_:)),
                                                     for: .valueChanged)
        allCategoryAvaliabilitySwitch.addTarget(self,
                                                action: #selector(changeAllCategoryAvaliability(_:)),
                                                for: .valueChanged)
    }

}

// MARK: - MainItemViewInput
extension MainItemViewController: MainItemViewInput {
    func updateAllSwitch(with state: Bool) {
        allCategoryAvaliabilitySwitch.setOn(state, animated: true)
    }

    func updatePaceSwitch(with state: Bool) {
        paceCategoryAvaliabilitySwitch.setOn(state, animated: true)
    }

    func updateTimeSwitch(with state: Bool) {
        timeCategoryAvaliabilitySwitch.setOn(state, animated: true)
    }

    func updateDistanceSwitch(with state: Bool) {
        distanceCategoryAvaliabilitySwitch.setOn(state, animated: true)
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

            paceCategoryAvaliabilitySwitch.centerXAnchor.constraint(equalTo: playPaceSoundButton.centerXAnchor),
            paceCategoryAvaliabilitySwitch.topAnchor.constraint(equalTo: playPaceSoundButton.bottomAnchor,
                                                                constant: Constansts.verticalIndent),

            playTimeSoundButton.leftAnchor.constraint(equalTo: playPaceSoundButton.rightAnchor,
                                                      constant: Constansts.horizontalIndent),
            playTimeSoundButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            playTimeSoundButton.widthAnchor.constraint(equalToConstant: buttonWidth),

            timeCategoryAvaliabilitySwitch.centerXAnchor.constraint(equalTo: playTimeSoundButton.centerXAnchor),
            timeCategoryAvaliabilitySwitch.topAnchor.constraint(equalTo: playTimeSoundButton.bottomAnchor,
                                                                constant: Constansts.verticalIndent),

            playDistanceSoundButton.leftAnchor.constraint(equalTo: playTimeSoundButton.rightAnchor,
                                                          constant: Constansts.horizontalIndent),
            playDistanceSoundButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            playDistanceSoundButton.widthAnchor.constraint(equalToConstant: buttonWidth),

            distanceCategoryAvaliabilitySwitch.centerXAnchor.constraint(equalTo: playDistanceSoundButton.centerXAnchor),
            distanceCategoryAvaliabilitySwitch.topAnchor.constraint(equalTo: playDistanceSoundButton.bottomAnchor,
                                                                    constant: Constansts.verticalIndent),

            allCategoryAvaliabilitySwitch.centerXAnchor.constraint(
                equalTo: timeCategoryAvaliabilitySwitch.centerXAnchor
            ),
            allCategoryAvaliabilitySwitch.topAnchor.constraint(equalTo: timeCategoryAvaliabilitySwitch.bottomAnchor,
                                                               constant: Constansts.verticalIndent),

            tableView.leftAnchor.constraint(equalTo: playPaceSoundButton.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: playDistanceSoundButton.rightAnchor),
            tableView.topAnchor.constraint(equalTo: allCategoryAvaliabilitySwitch.bottomAnchor,
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

    @objc private func changePaceCategoryAvaliability(_ sender: UISwitch) {
        presenter.changePaceCategoryAvaliability(to: sender.isOn)
    }

    @objc private func changeTimeCategoryAvaliability(_ sender: UISwitch) {
        presenter.changeTimeCategoryAvaliability(to: sender.isOn)
    }

    @objc private func changeDistanceCategoryAvaliability(_ sender: UISwitch) {
        presenter.changeDistanceCategoryAvaliability(to: sender.isOn)
    }

    @objc private func changeAllCategoryAvaliability(_ sender: UISwitch) {
        presenter.changeAllCategoryAvaliability(to: sender.isOn)
    }
}
