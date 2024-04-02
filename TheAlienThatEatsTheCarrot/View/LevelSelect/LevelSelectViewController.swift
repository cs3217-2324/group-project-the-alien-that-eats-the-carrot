//
//  LevelSelectViewController.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by zhing on 16/3/24.
//

import UIKit

class LevelSelectViewController: UIViewController, LevelViewDelegate {

    @IBOutlet private var scrollView: UIScrollView!
    @IBOutlet private var stackView: UIStackView!

    // Array containing level names
    private var levelNames: [String]!
    private var storageManager = LevelDataManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        levelNames = storageManager.fetchLevelNames()
        initializeLevelDesigner()
    }

    private func initializeLevelDesigner() {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        for levelName in levelNames {
            if let levelView = Bundle.main.loadNibNamed("LevelView", owner: nil, options: nil)?.first as? LevelView {
                // Customize the level view with level name and background image
                levelView.configure(levelName: levelName)

                // Set the view controller as the delegate
                levelView.delegate = self

                // Add the level view to the horizontal stack view
                stackView.addArrangedSubview(levelView)
            }
        }
    }

    func playButtonTapped(for levelName: String) {
        performSegue(withIdentifier: "PlayLevelSegue", sender: levelName)
    }

    @IBAction private func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }

    @IBAction private func unwindToLevelSelect(_ segue: UIStoryboardSegue) {
        // This method will be called when unwinding from the pause screen
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PlayLevelSegue",
           let gamePlayViewController = segue.destination as? GamePlayViewController,
           let levelName = sender as? String {
               gamePlayViewController.levelName = levelName
        }
    }
}
