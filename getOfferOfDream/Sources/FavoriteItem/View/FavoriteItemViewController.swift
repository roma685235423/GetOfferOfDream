import UIKit
import GetOfferUI
import GetOfferCore

// MARK: - FavoriteItemViewController
class FavoriteItemViewController: UIViewController {

    // MARK: - Private Properties
    private let presenter: FavoriteItemViewDelegate

    private let paceCategoryAvailabilitySwitch = UISwitch()
    private let timeCategoryAvailabilitySwitch = UISwitch()
    private let distanceCategoryAvailabilitySwitch = UISwitch()
    private let allCategoryAvailabilitySwitch = UISwitch()

    init(presenter: FavoriteItemViewDelegate) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Overrides Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemCyan
        view.addSubviews([paceCategoryAvailabilitySwitch, timeCategoryAvailabilitySwitch,
                          distanceCategoryAvailabilitySwitch, allCategoryAvailabilitySwitch])
        setConstraints()
        presenter.viewDidLoad()
        paceCategoryAvailabilitySwitch.addTarget(self,
                                                 action: #selector(changePaceCategoryAvailability(_:)),
                                                 for: .valueChanged)
        timeCategoryAvailabilitySwitch.addTarget(self,
                                                 action: #selector(changeTimeCategoryAvailability(_:)),
                                                 for: .valueChanged)
        distanceCategoryAvailabilitySwitch.addTarget(self,
                                                     action: #selector(changeDistanceCategoryAvailability(_:)),
                                                     for: .valueChanged)
        allCategoryAvailabilitySwitch.addTarget(self,
                                                action: #selector(changeAllCategoryAvailability(_:)),
                                                for: .valueChanged)
    }
}

// MARK: - FavoriteItemViewInput
extension FavoriteItemViewController: FavoriteItemViewInput {

    func updateSwitch(for group: AudioEventGroup, with state: Bool) {
        switch group {
        case .all:
            paceCategoryAvailabilitySwitch.setOn(state, animated: true)
            timeCategoryAvailabilitySwitch.setOn(state, animated: true)
            distanceCategoryAvailabilitySwitch.setOn(state, animated: true)
            allCategoryAvailabilitySwitch.setOn(state, animated: true)
        case .kilometerReached:
            distanceCategoryAvailabilitySwitch.setOn(state, animated: true)
        case .paceReached:
            paceCategoryAvailabilitySwitch.setOn(state, animated: true)
        case .percentageReached:
            timeCategoryAvailabilitySwitch.setOn(state, animated: true)
        }
    }

}

// MARK: - Private Methods
private extension FavoriteItemViewController {

    func setConstraints() {
        let switchHorizontalSpace = UIScreen.main.bounds.width / 4
        let firstSwitchX = switchHorizontalSpace / 2

        NSLayoutConstraint.activate([
            paceCategoryAvailabilitySwitch.centerXAnchor.constraint(equalTo: view.leftAnchor, constant: firstSwitchX),
            paceCategoryAvailabilitySwitch.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),

            timeCategoryAvailabilitySwitch.centerXAnchor.constraint(
                equalTo: paceCategoryAvailabilitySwitch.centerXAnchor,
                constant: switchHorizontalSpace
            ),
            timeCategoryAvailabilitySwitch.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),

            allCategoryAvailabilitySwitch.centerXAnchor.constraint(equalTo: view.rightAnchor, constant: -firstSwitchX),
            allCategoryAvailabilitySwitch.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),

            distanceCategoryAvailabilitySwitch.centerXAnchor.constraint(
                equalTo: allCategoryAvailabilitySwitch.centerXAnchor,
                constant: -switchHorizontalSpace
            ),
            distanceCategoryAvailabilitySwitch.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }

    @objc private func changePaceCategoryAvailability(_ sender: UISwitch) {
        presenter.changeAvailability(for: .paceReached, state: sender.isOn)
    }

    @objc private func changeTimeCategoryAvailability(_ sender: UISwitch) {
        presenter.changeAvailability(for: .percentageReached, state: sender.isOn)
    }

    @objc private func changeDistanceCategoryAvailability(_ sender: UISwitch) {
        presenter.changeAvailability(for: .kilometerReached, state: sender.isOn)
    }

    @objc private func changeAllCategoryAvailability(_ sender: UISwitch) {
        presenter.changeAvailability(for: .all, state: sender.isOn)
    }
}
