//
//  AchievementView.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by zhing on 20/4/24.
//

import UIKit

public class AchievementView {
    static func displayRectangularPopup(view: UIView, description: String) {
        let popupHeight: CGFloat = 80
        let popupWidth: CGFloat = 450
        let animationDuration: TimeInterval = 0.5
        let displayDuration: TimeInterval = 2.0

        // Create the rectangular popup view
        let popupView = UIView(frame: CGRect(x: (view.bounds.width - popupWidth) / 2, y: -popupHeight, width: popupWidth, height: popupHeight))
        popupView.backgroundColor = UIColor.systemGray4

        // Add image view on the left
        let imageView = UIImageView(frame: CGRect(x: 15, y: 8, width: 64, height: 64))
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "projectile-pellet")
        popupView.addSubview(imageView)

        // Add label on the right
        let promptLabel = UILabel(frame: CGRect(x: 80, y: 8, width: popupWidth - 100, height: popupHeight / 2))
        promptLabel.textAlignment = .center
        promptLabel.textColor = .black
        promptLabel.text = "Achievement Unlocked: "
        promptLabel.font = UIFont.boldSystemFont(ofSize: 18)
        popupView.addSubview(promptLabel)

        // Add label on the right
        let label = UILabel(frame: CGRect(x: 80, y: 34, width: popupWidth - 100, height: popupHeight / 2))
        label.textAlignment = .center
        label.textColor = .black
        label.text = description
        popupView.addSubview(label)

        // Add the popup view to the parent view
        view.addSubview(popupView)

        // Animate the popup sliding in
        UIView.animate(withDuration: animationDuration, animations: {
            popupView.frame.origin.y = 0
        }) { _ in
            // Delay for the display duration
            DispatchQueue.main.asyncAfter(deadline: .now() + displayDuration) {
                // Animate the popup sliding out
                UIView.animate(withDuration: animationDuration, animations: {
                    popupView.frame.origin.y = -popupHeight
                }) { _ in
                    // Remove the popup from the view hierarchy
                    popupView.removeFromSuperview()
                }
            }
        }
    }
}
