//
//  LevelDesignerViewController.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by zhing on 16/3/24.
//

import UIKit

class LevelDesignerViewController: UIViewController {

    @IBOutlet private var terrainsButton: UIButton!
    @IBOutlet private var enemiesButton: UIButton!
    @IBOutlet private var powerupsButton: UIButton!
    @IBOutlet private var collectiblesButton: UIButton!

    @IBOutlet private var terrainsContainerView: UIView!
    @IBOutlet private var enemiesContainerView: UIView!
    @IBOutlet private var powerupsContainerView: UIView!
    @IBOutlet private var collectiblesContainerView: UIView!
    private var componentSelected: ObjectType = .block(.normal)
    private var unitSize: CGFloat = 1.0
    private var boardBounds: (min: CGFloat, max: CGFloat)! // in absolute position
    private var displayBounds: (min: CGFloat, max: CGFloat)! // in absolute position

    @IBOutlet private var boardAreaView: UIView!
    private var imageViews: [ObjectIdentifier: RectangularImageView] = [:]
    var levelDesigner: LevelDesigner! // controller
    var levelDataManager = LevelDataManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpContainerViews()
        setUpGestures()
    }

    private func setUpContainerViews() {
        hideAllContainers()
        showContainerView(terrainsContainerView)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // initialise level desinger based on boardAreaView
        let frame = boardAreaView.frame
        self.unitSize = (frame.maxY - frame.minY) / 50

        // load default empty level
        if let level = levelDataManager.fetchEmptyLevel() {
            self.levelDesigner = LevelDesigner(level: level, view: self)
            boardBounds = (min: 0, max: level.area.size.width * unitSize)
            displayBounds = (min: 0, max: frame.maxX - frame.minX)
            print("display \(displayBounds) board \(boardBounds)")
        } else {
            let origin = CGPoint(x: 0, y: 0)
            let size = CGSize(width: (frame.maxX - frame.minX) / unitSize, height: (frame.maxY - frame.minY) / unitSize)
            let area = CGRect(origin: origin, size: size)
            if levelDesigner == nil {
                self.levelDesigner = LevelDesigner(area: area, view: self)
            }
            displayBounds = (min: 0, max: (frame.maxX - frame.minX))
            displayBounds = (min: 0, max: (frame.maxX - frame.minX))
        }
    }

    // MARK: - set up tab bars
    /// Set up container view's view controllers
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TerrainsViewSegue" {
            if let terrainsViewController = segue.destination as? TerrainsViewController {
                terrainsViewController.delegate = self
            }
        }
        if segue.identifier == "EnemiesViewSegue" {
            if let enemiesViewController = segue.destination as? EnemiesViewController {
                enemiesViewController.delegate = self
            }
        }
        if segue.identifier == "PowerupsViewSegue" {
            if let powerupsViewController = segue.destination as? PowerupsViewController {
                powerupsViewController.delegate = self
            }
        }
        if segue.identifier == "CollectiblesViewSegue" {
            if let collectivlesViewController = segue.destination as? CollectiblesViewController {
                collectivlesViewController.delegate = self
            }
        }
        if segue.identifier == "SaveLevelSegue",
           let destination = segue.destination as? SaveLevelViewController {
            destination.delegate = self
        }
        if segue.identifier == "LoadLevelSegue",
           let destination = segue.destination as? LoadLevelViewController {
            destination.delegate = self
            destination.levelNames = levelDesigner.fetchLevelNames()
        }
//        if segue.identifier == "TestGameSegue",
//           let gameViewController = segue.destination as? GameViewController {
//            gameViewController.level = levelDesigner.level
//        }
    }

    private func hideAllContainers() {
        terrainsContainerView.isHidden = true
        enemiesContainerView.isHidden = true
        powerupsContainerView.isHidden = true
        collectiblesContainerView.isHidden = true
    }

    private func showContainerView(_ containerView: UIView) {
       hideAllContainers()
       containerView.isHidden = false
    }

    @IBAction private func terrainsButtonTapped(_ sender: UIButton) {
       showContainerView(terrainsContainerView)
    }

    @IBAction private func enemiesButtonTapped(_ sender: UIButton) {
       showContainerView(enemiesContainerView)
    }

    @IBAction private func powerupsButtonTapped(_ sender: UIButton) {
       showContainerView(powerupsContainerView)
    }

    @IBAction private func collectiblesButtonTapped(_ sender: UIButton) {
       showContainerView(collectiblesContainerView)
    }

    // MARK: - user interactions

    private func setUpGestures() {
        // tap to add game object
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleBoardTap(_:)))
        boardAreaView.addGestureRecognizer(singleTapGesture)

        // long press >0.8s to delete game object
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleBoardLongPress(_:)))
        longPressGesture.minimumPressDuration = 0.7 // Adjust the duration as needed
        boardAreaView.addGestureRecognizer(longPressGesture)

        // long press and drag to move game object
        let panGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleBoardPan(_:)))
        panGesture.minimumPressDuration = 0.2
        boardAreaView.addGestureRecognizer(panGesture)
        panGesture.require(toFail: longPressGesture)

        // pan to move screen
        let shortHoldPanGesture = UIPanGestureRecognizer(target: self, action: #selector(handleShortHoldPan(_:)))
        boardAreaView.addGestureRecognizer(shortHoldPanGesture)
    }

    /// handle tap action in the board area
    @objc func handleBoardTap(_ gesture: UITapGestureRecognizer) {
        let tapLocation = toUnitPosition(position: gesture.location(in: boardAreaView))
        print("tap at \(tapLocation)")
        levelDesigner.handleTap(at: tapLocation, objectType: componentSelected)
    }

    /// handle long press action in the board area
    @objc func handleBoardLongPress(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            let location = toUnitPosition(position: gesture.location(in: boardAreaView))
            print("long press (delete) at \(location)")
            levelDesigner.handleLongPress(at: location)
        }
    }

    /// handle pan action in the board area
    @objc func handleBoardPan(_ gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            print("long press pan began")
            let touchPoint = toUnitPosition(position: gesture.location(in: boardAreaView))
            levelDesigner.handlePanStart(at: touchPoint)
        case .changed:
            print("long press pan change")
            let touchPoint = toUnitPosition(position: gesture.location(in: boardAreaView))
            levelDesigner.handlePanChange(at: touchPoint)
        default:
            print("long press pan end")
            levelDesigner.handlePanEnd()
        }
    }

    // move the screen
    @objc func handleShortHoldPan(_ gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            print("short pan began")
        case .changed:
            let translation = gesture.translation(in: boardAreaView)
            moveAllImages(scale: translation.x)
            gesture.setTranslation(.zero, in: boardAreaView)
            print("short pan change \(translation.x)")
        default:
            print("stort pan end")
        }
    }

    private func toUnitPosition(position: CGPoint) -> CGPoint {
        CGPoint(x: position.x / unitSize, y: position.y / unitSize)
    }

    private func toBoardPosition(position: CGPoint) -> CGPoint {
        CGPoint(x: position.x * unitSize, y: position.y * unitSize)
    }

    // MARK: - image handling
    func addImage(id: ObjectIdentifier, objectType: ObjectType, center: CGPoint, width: CGFloat, height: CGFloat) {
//        print(">>view >> image added at \(toBoardPosition(position: center)) for \(objectType) w \(width * unitSize) h \(height * unitSize)")
        let imageView = RectangularImageView(objectType: objectType, center: toBoardPosition(position: center), width: width * unitSize, height: height * unitSize)
        imageViews[id] = imageView
        boardAreaView.addSubview(imageView.imageView)
    }

    func removeImage(id: ObjectIdentifier) {
//        print("image removed for \(id)")
        guard let removedImageView = imageViews.removeValue(forKey: id) else {
            return
        }
        removedImageView.imageView.removeFromSuperview()
        removedImageView.imageView = nil
    }

    func moveAllImages(scale: CGFloat) {
        var distance = scale
        if displayBounds.min - scale < boardBounds.min {
            distance = displayBounds.min - boardBounds.min
        } else if displayBounds.max - scale > boardBounds.max {
            distance = boardBounds.max - displayBounds.max
        }

        displayBounds = (min: displayBounds.min - distance, max: displayBounds.max - distance)
        for (_, imageView) in imageViews {
            imageView.center.x += distance
            imageView.imageView.center = imageView.center
        }
    }

    // MARK: - other feature buttons
    @IBAction private func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }

    func reset() {
        for imageView in imageViews.values {
            imageView.imageView.removeFromSuperview()
            imageView.imageView = nil
        }
        imageViews.removeAll()
    }

    func printJSON(level: Level) {
        if let jsonString = level.toJSONString() {
            print("JSON String: ")
            print(jsonString)
        }

    }

    @IBAction private func playLevelButtonTapped(_ sender: UIButton) {
        printJSON(level: levelDesigner.level)
    }

}

extension LevelDesignerViewController: ComponentSelectDelegate {
    func buttonTapped(type: ObjectType) {
        componentSelected = type
    }
}

extension LevelDesignerViewController: SaveLevelViewControllerDelegate {
    func saveLevel(levelName: String, overwrite: Bool) throws {
        try levelDesigner.saveLevel(levelName: levelName, overwrite: overwrite)
    }
}

extension LevelDesignerViewController: LoadLevelViewControllerDelegate {
    func loadLevel(levelName: String) throws {
        try levelDesigner.loadLevel(levelName: levelName)
    }
}
