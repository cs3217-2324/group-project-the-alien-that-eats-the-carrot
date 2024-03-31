//
//  SaveLevelViewController.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by zhing on 24/3/24.
//

import UIKit

class SaveLevelViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet private var informationLabel: UILabel!
    @IBOutlet private var levelNameField: UITextField!
    weak var delegate: SaveLevelViewControllerDelegate?
    private var overwrite = false

    override func viewDidLoad() {
        super.viewDidLoad()
        levelNameField.delegate = self
    }
    
    @IBAction private func cancelButtonPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        overwrite = false
        informationLabel.text = " "
        return true
    }

    @IBAction func saveButtonPressed(_ sender: UIButton) {
        guard let levelName = levelNameField.text, !levelName.isEmpty else {
            informationLabel.text = "LEVEL NAME CANNOT BE EMPTY"
            return
        }
        do {
            try delegate?.saveLevel(levelName: levelName, overwrite: overwrite)
            informationLabel.text = "LEVEL SAVED SUCCESSFULLY!"
            overwrite = false
        } catch TheAlienThatEatsTheCarrotError.duplicateLevelNameError {
            informationLabel.text = "LEVEL EXISTS, SAVE AGAIN TO OVERWRITE"
            self.overwrite = true
//        } catch PeggleError.cannotOverrideDefaultLevelError {
//            informationLabel.text = "Default levels cannot be overidden."
        } catch {
            throwAlert(message: "Unexpected error: \(error)")
        }
    }

    private func throwAlert(message: String) {
        let alertMessage = message
        let alert = UIAlertController(title: "Error", message: alertMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Okay", style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }

}

protocol SaveLevelViewControllerDelegate: AnyObject {
    func saveLevel(levelName: String, overwrite: Bool) throws
}
