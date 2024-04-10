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

    var levelName: String?
    var renderableComponents: [RenderableComponent] = []
    var gameStats: GameStats!
    private var imageViews: [ObjectIdentifier: RectangularImageView] = [:]

    // MARK: - game loop
    var gameEngine: GameEngine!
    var gameLoop: GameLoop!
    var levelDataManager = LevelDataManager()

    private var isGameLoopRunning = false
    var count: Int = 0

    // MARK: observers
    private var damageObserver: NSObjectProtocol?

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let levelNameToLoad = levelName else {
            return
        }
        do {
            let level = try levelDataManager.fetchLevel(levelName: levelNameToLoad)
            gameEngine = GameEngine(level: level)
            subscribeToEvents()
        } catch {
            print("Error loading level \(levelNameToLoad): \(error)")
            presentAlert(message: "Failed to load level: \(error.localizedDescription)")
        }
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
        isGameLoopRunning = false
    }

    private func updateUI() {
        reset() // here I removes everything that is previously added
        // if you want to remove image indiviudally call `removeImage(id: ObjectIdentifier(component))`
        renderableComponents = gameEngine.getRenderableComponents()
        gameStats = gameEngine.getGameStats()

        for component in renderableComponents {
            addImage(id: ObjectIdentifier(component), objectType: component.objectType, center: component.position, width: component.size.width, height: component.size.height)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopGameLoop()
        if let observer = damageObserver {
            EventManager.shared.unsubscribe(from: observer)
        }
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
        let imageView = RectangularImageView(objectType: objectType, center: center, width: width, height: height)
        imageViews[id] = imageView
        boardAreaView.addSubview(imageView.imageView)
    }

    func removeImage(id: ObjectIdentifier) {
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

    private func subscribeToEvents() {
        damageObserver = EventManager.shared.subscribe(to: DamageEvent.self, using: onEventOccur)
    }

    private lazy var onEventOccur = { [weak self] (event: Event) -> Void in
        if let damageEvent = event as? DamageEvent {
            self?.showDamage(at: damageEvent.position, amount: damageEvent.damage)
        }
    }
}

extension GamePlayViewController {
    func showDamage(at position: CGPoint, amount: CGFloat) {
        let damageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        damageLabel.text = "-\(amount)"
        damageLabel.textColor = .red
        damageLabel.center = position
        boardAreaView.addSubview(damageLabel)

        UIView.animate(withDuration: 1.0, animations: {
            damageLabel.alpha = 0
            damageLabel.center.y -= 50
        }) { _ in
            damageLabel.removeFromSuperview()
        }
    }
}
