//
//  LoadLevelViewController.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by zhing on 24/3/24.
//

import UIKit

class LoadLevelViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var tableView: UITableView!

    var levelNames: [String]!
    weak var delegate: LoadLevelViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.backgroundColor = .clear
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "LevelCell")
    }

    // MARK: - UITableView DataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        levelNames.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LevelCell", for: indexPath)
        cell.textLabel?.text = levelNames[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
//        cell.backgroundColor = .clear
        return cell
    }

    // MARK: - UITableView Delegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }

    @IBAction private func loadButtonTapped(_ sender: UIButton) {
        guard let selectedRow = tableView.indexPathForSelectedRow else {
            // No row is selected, return
            return
        }
        do {
            try delegate?.loadLevel(levelName: levelNames[selectedRow.row])
        } catch {
            return
        }
    }

    @IBAction private func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
}

protocol LoadLevelViewControllerDelegate: AnyObject {
    func loadLevel(levelName: String) throws
}
