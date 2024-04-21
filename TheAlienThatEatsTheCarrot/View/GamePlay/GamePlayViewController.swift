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
    private var scale: CGFloat = 50.0
    private var unitSize: CGFloat = 1.0

    // MARK: - game utility classes
    var gameEngine: GameEngine!
    var gameRenderer: GameRenderer!
    var gameLoop: GameLoop!
    var levelDataManager = LevelDataManager()

    private var isGameLoopRunning = false
    var count: Int = 0

    // MARK: observers
    private var damageObserver: NSObjectProtocol?
    private var playerDiedObserver: NSObjectProtocol?
    private var powerupActivateObserver: NSObjectProtocol?
    private var gameEndObserver: NSObjectProtocol?

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let levelNameToLoad = levelName else {
            return
        }
        do {
            let level = try levelDataManager.fetchLevel(levelName: levelNameToLoad)
            gameEngine = GameEngine(level: level, bounds: boardAreaView.bounds)
            subscribeToEvents()
        } catch {
            presentAlert(message: "Failed to load level: \(error.localizedDescription)")
        }

        let frame = boardAreaView.frame
        self.unitSize = (frame.maxY - frame.minY) / scale
        self.gameRenderer = GameRenderer(scale: scale, unitSize: unitSize, boardAreaFrame: frame)
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
            addImage(component: component)
        }

        updateCoinCount(gameStats.coins)
        updateCarrotCount(gameStats.carrots)
        updateLivesCount(gameStats.lives)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopGameLoop()
        unsubscribeToEvents()
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

    func addImage(component: RenderableComponent) {
        let playerPosition = gameEngine.getPlayerPositions().first
        let positionWithOffsets = gameRenderer.getPositionWithOffsets(for: component.position, playerPosition: playerPosition)
        let imageView = RectangularImageView(objectType: component.objectType,
                                             center: positionWithOffsets,
                                             width: component.size.width * unitSize,
                                             height: component.size.height * unitSize)
        imageViews[ObjectIdentifier(component)] = imageView
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

    private func toUnitPosition(position: CGPoint) -> CGPoint {
        CGPoint(x: position.x / unitSize, y: position.y / unitSize)
    }

    private func toBoardPosition(position: CGPoint) -> CGPoint {
        CGPoint(x: position.x * unitSize, y: position.y * unitSize)
    }

    // MARK: - game state handling
    private func updateCoinCount(_ count: Int) {
        coinCountText.text = String(count)
    }

    private func updateCarrotCount(_ number: Int) {
        let fullCarrot = #imageLiteral(resourceName: "carrot-1")
        let emptyCarrot = #imageLiteral(resourceName: "carrot-2")

        carrot1.image = number > 0 ? fullCarrot : emptyCarrot
        carrot2.image = number > 1 ? fullCarrot : emptyCarrot
        carrot3.image = number > 2 ? fullCarrot : emptyCarrot
    }

    private func updateLivesCount(_ counts: [Int]) {
        let fullLife = #imageLiteral(resourceName: "heart-full")
        let emptyLife = #imageLiteral(resourceName: "heart-empty")

        if !counts.isEmpty {
            life1.image = counts[0] > 0 ? fullLife : emptyLife
            life2.image = counts[0] > 1 ? fullLife : emptyLife
            life3.image = counts[0] > 2 ? fullLife : emptyLife
        }
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

    @IBAction private func jumpButtonTouchDown(_ sender: UIButton) {
        sender.backgroundColor = sender.backgroundColor?.withAlphaComponent(0.5)
    }

    @IBAction private func jumpButtonTapped(_ sender: UIButton) {
        sender.backgroundColor = sender.backgroundColor?.withAlphaComponent(0.3)
        EventManager.shared.postEvent(PlayerControlActionEvent(action: .jump))
    }

    @IBAction private func jumpButtonTouchUpOutside(_ sender: UIButton) {
        sender.backgroundColor = sender.backgroundColor?.withAlphaComponent(0.3)
    }

    // MARK: - pause
    @IBAction private func pauseButtonTapped(_ sender: UIButton) {
        stopGameLoop()
        performSegue(withIdentifier: "PauseScreenSegue", sender: self)
//        goToGameOverScreen()
//        goToGameClearScreen()
    }

    @IBAction private func unwindFromPauseScreen(segue: UIStoryboardSegue) {
        // This method will be called when the PauseScreenViewController is dismissed
        startGameLoop()
    }

    // MARK: - game over
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GameOverScreenSegue" {
            if let gameOverVC = segue.destination as? GameOverViewController {
                gameOverVC.delegate = self
            }
        }
        if segue.identifier == "LevelClearedSegue" {
            if let levelClearedVC = segue.destination as? LevelClearedViewController {
                levelClearedVC.delegate = self
                gameStats = gameEngine.getGameStats()
                levelClearedVC.gameStats = gameStats
            }
        }
    }

    private func goToGameOverScreen() {
        stopGameLoop()
        performSegue(withIdentifier: "GameOverScreenSegue", sender: self)
    }

    // MARK: - game clear
    private func goToGameClearScreen() {
        stopGameLoop()
        performSegue(withIdentifier: "LevelClearedSegue", sender: self)
    }

    // MARK: - events
    private func subscribeToEvents() {
        damageObserver = EventManager.shared.subscribe(to: DamageEvent.self, using: onEventOccur)
        playerDiedObserver = EventManager.shared.subscribe(to: PlayerDiedEvent.self, using: onEventOccur)
        powerupActivateObserver = EventManager.shared.subscribe(to: PowerupActivateEvent.self, using: onEventOccur)
        gameEndObserver = EventManager.shared.subscribe(to: GameEndEvent.self, using: onEventOccur)
    }

    private func unsubscribeToEvents() {
        if let observer1 = damageObserver {
            EventManager.shared.unsubscribe(from: observer1)
        }
        if let observer2 = playerDiedObserver {
            EventManager.shared.unsubscribe(from: observer2)
        }
        if let observer3 = powerupActivateObserver {
            EventManager.shared.unsubscribe(from: observer3)
        }
        if let observer4 = gameEndObserver {
            EventManager.shared.unsubscribe(from: observer4)
        }
    }

    private lazy var onEventOccur = { [weak self] (event: Event) -> Void in
        let playerPosition = self?.gameEngine.getPlayerPositions().first
        if let damageEvent = event as? DamageEvent {
            self?.showDamage(at: damageEvent.position, amount: damageEvent.damage, for: playerPosition)
        } else if let playerDiedEvent = event as? PlayerDiedEvent {
            self?.gameStats = self?.gameEngine.getGameStats()
            if self?.gameStats.lives[0] ?? 0 > 0 {
                self?.showPlayerDied()
            }
        } else if let powerupActivateEvent = event as? PowerupActivateEvent {
            self?.showPowerupActivated(for: powerupActivateEvent.name, at: powerupActivateEvent.position, for: playerPosition)
        } else if let gameEndEvent = event as? GameEndEvent {
            if gameEndEvent.isWin {
                self?.goToGameClearScreen()
            } else {
                self?.goToGameOverScreen()
            }
        }
    }
}

extension GamePlayViewController {
    func showDamage(at position: CGPoint, amount: CGFloat, for playerPosition: CGPoint?) {
        let positionWithOffsets = gameRenderer.getPositionWithOffsets(for: position,
                                                                      playerPosition: playerPosition)
        let damageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 125, height: 50))
        damageLabel.text = "-\(amount)"
        damageLabel.textColor = .red
        damageLabel.center = positionWithOffsets
        boardAreaView.addSubview(damageLabel)
        damageLabel.layer.zPosition = 100

        UIView.animate(withDuration: 1.0, animations: {
            damageLabel.alpha = 0
            damageLabel.center.y -= 50
        }) { _ in
            damageLabel.removeFromSuperview()
        }
    }

    func showPlayerDied() {
        let diedLabel = UILabel()
        diedLabel.text = "YOU DIED"
        diedLabel.textColor = .red
        diedLabel.font = UIFont.boldSystemFont(ofSize: 80)
        diedLabel.sizeToFit()
        diedLabel.center = boardAreaView.center
        diedLabel.alpha = 0
        view.addSubview(diedLabel)

        UIView.animate(withDuration: 0.5, animations: {
            diedLabel.alpha = 1
        }) { _ in
            UIView.animate(withDuration: 1.0, delay: 2.0, options: [], animations: {
                diedLabel.alpha = 0
            }) { _ in
                diedLabel.removeFromSuperview()
            }
        }
    }

    func showPowerupActivated(for name: String, at position: CGPoint, for playerPosition: CGPoint?) {
        let positionWithOffsets = gameRenderer.getPositionWithOffsets(for: position,
                                                                      playerPosition: playerPosition)
        let powerupLabel = UILabel()
        powerupLabel.text = "\(name) Activated!"
        powerupLabel.textColor = .green
        powerupLabel.font = UIFont.boldSystemFont(ofSize: 40)
        powerupLabel.sizeToFit()
        powerupLabel.center = boardAreaView.center
        powerupLabel.alpha = 0
        view.addSubview(powerupLabel)

        let circleView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        circleView.center = positionWithOffsets
        circleView.layer.cornerRadius = 15
        circleView.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.6)
        circleView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        boardAreaView.addSubview(circleView)

        UIView.animate(withDuration: 0.5, animations: {
            circleView.transform = CGAffineTransform(scaleX: 12, y: 12)
            circleView.alpha = 0
            powerupLabel.alpha = 1
        }) { _ in
            circleView.removeFromSuperview()
        }

        UIView.animate(withDuration: 0.5, delay: 1.0, options: [], animations: {
            powerupLabel.alpha = 0
        }) { _ in
            powerupLabel.removeFromSuperview()
        }
    }

}

extension GamePlayViewController: GameClearReplayDelegate {
    func replayGameFromGameClear() {
    }
}

extension GamePlayViewController: GameOverReplayDelegate {
    func replayGameFromGameOver() {
        guard let levelNameToLoad = levelName else {
            return
        }
        do {
            let level = try levelDataManager.fetchLevel(levelName: levelNameToLoad)
            gameEngine = GameEngine(level: level, bounds: boardAreaView.bounds)
            subscribeToEvents()
        } catch {
            presentAlert(message: "Failed to load level: \(error.localizedDescription)")
        }

        let frame = boardAreaView.frame
        self.unitSize = (frame.maxY - frame.minY) / scale

        self.gameLoop = GameLoop(gameEngine: gameEngine, updateUI: { [weak self] in
            self?.updateUI()
        })
        startGameLoop()
    }
}
