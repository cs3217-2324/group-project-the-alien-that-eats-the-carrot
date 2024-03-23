//
//  LevelView.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by zhing on 22/3/24.
//

import UIKit
import AVFoundation

protocol LevelViewDelegate: AnyObject {
    func playButtonTapped(for levelName: String)
}

class LevelView: UIView {
    weak var delegate: LevelViewDelegate?
    
    @IBOutlet private var levelNameText: UILabel!
    @IBOutlet private var carrot1: UIImageView!
    @IBOutlet private var carrot2: UIImageView!
    @IBOutlet private var carrot3: UIImageView!
    @IBOutlet private var bestScoreText: UILabel!
    @IBOutlet private var bestTimeText: UILabel!
    @IBOutlet private var playButton: UIButton!
    
    // Function to configure the level view with data
    func configure(levelName: String) {
        levelNameText.text = levelName
    }
    
    @IBAction private func playButtonTapped(_ sender: UIButton) {
        delegate?.playButtonTapped(for: levelNameText.text ?? "")
    }
    
}
