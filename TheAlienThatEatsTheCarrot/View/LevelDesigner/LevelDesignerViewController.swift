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

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpContainerViews()
    }

    private func setUpContainerViews() {
        hideAllContainers()
        showContainerView(terrainsContainerView)

        // set up delegate = self
    }
    
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

    @IBAction func terrainsButtonTapped(_ sender: UIButton) {
       showContainerView(terrainsContainerView)
    }

    @IBAction func enemiesButtonTapped(_ sender: UIButton) {
       showContainerView(enemiesContainerView)
    }

    @IBAction func powerupsButtonTapped(_ sender: UIButton) {
       showContainerView(powerupsContainerView)
    }

    @IBAction func collectiblesButtonTapped(_ sender: UIButton) {
       showContainerView(collectiblesContainerView)
    }

}

extension LevelDesignerViewController: ComponentSelectDelegate {
    func buttonTapped(type: ObjectType) {
        componentSelected = type
        print("Type selecteed: \(type)")
    }
}
