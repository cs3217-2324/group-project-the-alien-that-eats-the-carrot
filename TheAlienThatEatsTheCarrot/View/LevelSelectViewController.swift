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
    let levelNames = ["Level 1", "Level 2", "Level 3", "Level 4", "Level 5"]

    override func viewDidLoad() {
        super.viewDidLoad()
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
        performSegue(withIdentifier: "PlayLevelSegue", sender: nil)
    }
    
    @IBAction private func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func unwindToLevelSelect(_ segue: UIStoryboardSegue) {
        // This method will be called when unwinding from the pause screen
    }
}
