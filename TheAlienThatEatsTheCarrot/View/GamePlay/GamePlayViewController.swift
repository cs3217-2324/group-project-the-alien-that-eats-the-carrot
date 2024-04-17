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
    private var unitSize: CGFloat = 1.0

    // MARK: - game loop
    var gameEngine: GameEngine!
    var gameLoop: GameLoop!
    var levelDataManager = LevelDataManager()

    private var isGameLoopRunning = false
    var count: Int = 0

    // MARK: observers
    private var damageObserver: NSObjectProtocol?
    private var playerDiedObserver: NSObjectProtocol?
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
            print("Error loading level \(levelNameToLoad): \(error)")
            presentAlert(message: "Failed to load level: \(error.localizedDescription)")
        }

        let frame = boardAreaView.frame
        self.unitSize = (frame.maxY - frame.minY) / 50
        print("game page unitSize \(unitSize)")
        print("area bottom: \(frame.minY), top: \(frame.maxY), left: \(frame.minX), right: \(frame.maxX).")

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
        let imageView = RectangularImageView(objectType: component.objectType, center: toBoardPosition(position: component.position), width: component.size.width * unitSize, height: component.size.height * unitSize)
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
        gameEndObserver = EventManager.shared.subscribe(to: GameEndEvent.self, using: onEventOccur)
    }

    private func unsubscribeToEvents() {
        if let observer1 = damageObserver {
            EventManager.shared.unsubscribe(from: observer1)
        }
        if let observer2 = playerDiedObserver {
            EventManager.shared.unsubscribe(from: observer2)
        }
        if let observer3 = gameEndObserver {
            EventManager.shared.unsubscribe(from: observer3)
        }
    }

    private lazy var onEventOccur = { [weak self] (event: Event) -> Void in
        if let damageEvent = event as? DamageEvent {
            self?.showDamage(at: damageEvent.position, amount: damageEvent.damage)
        } else if let playerDiedEvent = event as? PlayerDiedEvent {
            self?.showPlayerDied()
            self?.goToGameOverScreen()
        } else if let gameEndEvent = event as? GameEndEvent {
            self?.goToGameOverScreen()
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
}

extension GamePlayViewController: GameOverDelegate {
    func replayGame() {
        // TODO: Implement your replay logic here
        print("replay game")
    }
}
