//
//  GamePlayViewController.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by zhing on 16/3/24.
//

import UIKit

class GamePlayViewController: UIViewController {

    @IBOutlet private var carrot1: UIImageView!
    @IBOutlet private var carrot2: UIImageView!
    @IBOutlet private var carrot3: UIImageView!
    @IBOutlet private var life1: UIImageView!
    @IBOutlet private var life2: UIImageView!
    @IBOutlet private var life3: UIImageView!
    @IBOutlet private var coinCountText: UILabel!
    @IBOutlet private var boardAreaView: UIView!

    var renderableComponents: [RenderableComponent] = []
    private var imageViews: [ObjectIdentifier: RectangularImageView] = [:]

    // MARK: - game loop
    let gameEngine = GameEngine()
    var gameLoop: GameLoop!

    private var isGameLoopRunning = false
    var count: Int = 0

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.gameLoop = GameLoop(gameEngine: gameEngine, updateUI: { [weak self] in
            self?.updateUI()
        })
        startGameLoop()
    }

    private func startGameLoop() {
        guard !isGameLoopRunning else {
            return
        }
        gameLoop.start()
        isGameLoopRunning = true
    }

    private func stopGameLoop() {
        guard isGameLoopRunning else {
            return
        }
        gameLoop.stop()
    }

    private func updateUI() {
        reset() // here I removes everything that is previously added
        // if you want to remove image indiviudally call `removeImage(id: ObjectIdentifier(component))`
        renderableComponents = gameEngine.getRenderableComponents()
        for component in renderableComponents {
            addImage(id: ObjectIdentifier(component), objectType: component.objectType, center: component.position, width: component.size.width, height: component.size.height)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopGameLoop()
    }

    private func presentAlert(message: String) {
        let alertMessage = message
        let alert = UIAlertController(title: "Error", message: alertMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Okay", style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }

    // MARK: - image handling
    func addImage(id: ObjectIdentifier, objectType: ObjectType, center: CGPoint, width: CGFloat, height: CGFloat) {
        print("image added at \(center) for \(id)")
        let imageView = RectangularImageView(objectType: objectType, center: center, width: width, height: height)
        imageViews[id] = imageView
        boardAreaView.addSubview(imageView.imageView)
    }

    func removeImage(id: ObjectIdentifier) {
        print("image removed for \(id)")
        guard let removedImageView = imageViews.removeValue(forKey: id) else {
            return
        }
        removedImageView.imageView.removeFromSuperview()
        removedImageView.imageView = nil
    }

    func reset() {
        for imageView in imageViews.values {
            imageView.imageView.removeFromSuperview()
            imageView.imageView = nil
        }
        imageViews.removeAll()
    }

    // MARK: - image handling
    func addImage(id: ObjectIdentifier, objectType: ObjectType, center: CGPoint, width: CGFloat, height: CGFloat) {
        print("image added at \(center) for \(id)")
        let imageView = RectangularImageView(objectType: objectType, center: center, width: width, height: height)
        imageViews[id] = imageView
        boardAreaView.addSubview(imageView.imageView)
    }

    func removeImage(id: ObjectIdentifier) {
        print("image removed for \(id)")
        guard let removedImageView = imageViews.removeValue(forKey: id) else {
            return
        }
        removedImageView.imageView.removeFromSuperview()
        removedImageView.imageView = nil
    }

    func reset() {
        for imageView in imageViews.values {
            imageView.imageView.removeFromSuperview()
            imageView.imageView = nil
        }
        imageViews.removeAll()
    }

    // MARK: - character movement
    var isLeftButtonPressed = false
    var isRightButtonPressed = false

    @IBAction private func moveLeftButtonTouchDown(_ sender: UIButton) {
        sender.backgroundColor = sender.backgroundColor?.withAlphaComponent(0.5)
        isLeftButtonPressed = true
        EventManager.shared.postEvent(PlayerControlActionEvent(action: .left))
    }

    @IBAction private func moveLeftButtonTouchUp(_ sender: UIButton) {
        sender.backgroundColor = sender.backgroundColor?.withAlphaComponent(0.3)
        isLeftButtonPressed = false
        EventManager.shared.postEvent(PlayerControlActionEvent(action: .idle))
    }

    @IBAction private func moveRightButtonTouchDown(_ sender: UIButton) {
        sender.backgroundColor = sender.backgroundColor?.withAlphaComponent(0.5)
        isLeftButtonPressed = true
        EventManager.shared.postEvent(PlayerControlActionEvent(action: .right))
    }

    @IBAction private func moveRightButtonTouchUp(_ sender: UIButton) {
        sender.backgroundColor = sender.backgroundColor?.withAlphaComponent(0.3)
        isLeftButtonPressed = false
        EventManager.shared.postEvent(PlayerControlActionEvent(action: .idle))
    }

    @IBAction func jumpButtonTouchDown(_ sender: UIButton) {
        sender.backgroundColor = sender.backgroundColor?.withAlphaComponent(0.5)
    }

    @IBAction private func jumpButtonTapped(_ sender: UIButton) {
        sender.backgroundColor = sender.backgroundColor?.withAlphaComponent(0.3)
        EventManager.shared.postEvent(PlayerControlActionEvent(action: .jump))
    }

    @IBAction func jumpButtonTouchUpOutside(_ sender: UIButton) {
        sender.backgroundColor = sender.backgroundColor?.withAlphaComponent(0.3)
    }

    // MARK: - pause
    @IBAction private func pauseButtonTapped(_ sender: UIButton) {
        stopGameLoop()
        performSegue(withIdentifier: "PauseScreenSegue", sender: self)
    }

    @IBAction private func unwindFromPauseScreen(segue: UIStoryboardSegue) {
        // This method will be called when the PauseScreenViewController is dismissed
        startGameLoop()
    }

}
