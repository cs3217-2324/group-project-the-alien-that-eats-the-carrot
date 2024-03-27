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

    var renderableComponents: [RenderableComponent] = []

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
        renderableComponents = gameEngine.getRenderableComponents()
        for component in renderableComponents {
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

    // MARK: - character movement
    var isLeftButtonPressed = false
    var isRightButtonPressed = false

    @IBAction private func moveLeftButtonTouchDown(_ sender: UIButton) {
        sender.backgroundColor = sender.backgroundColor?.withAlphaComponent(0.5)
        isLeftButtonPressed = true
        print("left true")
        EventManager.shared.postEvent(PlayerMoveEvent(action: .left))
    }

    @IBAction private func moveLeftButtonTouchUp(_ sender: UIButton) {
        sender.backgroundColor = sender.backgroundColor?.withAlphaComponent(0.3)
        isLeftButtonPressed = false
        print("left false")
        EventManager.shared.postEvent(PlayerMoveEvent(action: .idle))
    }

    @IBAction private func moveRightButtonTouchDown(_ sender: UIButton) {
        sender.backgroundColor = sender.backgroundColor?.withAlphaComponent(0.5)
        isLeftButtonPressed = true
        print("right true")
        EventManager.shared.postEvent(PlayerMoveEvent(action: .right))
    }

    @IBAction private func moveRightButtonTouchUp(_ sender: UIButton) {
        sender.backgroundColor = sender.backgroundColor?.withAlphaComponent(0.3)
        isLeftButtonPressed = false
        print("right false")
        EventManager.shared.postEvent(PlayerMoveEvent(action: .idle))
    }

    @IBAction private func jumpButtonTapped(_ sender: UIButton) {
        print("jump")
        EventManager.shared.postEvent(PlayerMoveEvent(action: .jump))
    }

    // MARK: - pause
    @IBAction private func pauseButtonTapped(_ sender: UIButton) {
        stopGameLoop()
        performSegue(withIdentifier: "PauseScreenSegue", sender: self)
    }

    @IBAction private func unwindFromPauseScreen(segue: UIStoryboardSegue) {
        // This method will be called when the PauseScreenViewController is dismissed
        print("start agains")
        startGameLoop()
    }

}
