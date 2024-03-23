//
//  LevelView.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by zhing on 22/3/24.
//

import UIKit

class LevelView: UIView {
    
    @IBOutlet weak var levelNameText: UILabel!
    
    
    // Function to configure the level view with data
    func configure(levelName: String) {
        levelNameText.text = levelName
    }
}
