import UIKit

protocol MainItemViewDelegate: AnyObject {
    func viewDidLoad()
    func playPaceSound()
    func playTimeSound()
    func playDistanceSound()
    func changePaceCategoryAvaliability(to state: Bool)
    func changeTimeCategoryAvaliability(to state: Bool)
    func changeDistanceCategoryAvaliability(to state: Bool)
    func changeAllCategoryAvaliability(to state: Bool)
}
