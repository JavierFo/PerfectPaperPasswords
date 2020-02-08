//
//  KeysController.swift
//  PerfectPaperPasswords
//
//  Created by Javier Ferrer on 2/6/20.
//  Copyright © 2020 Javier Ferrer. All rights reserved.
//

import UIKit

class KeysController: UIViewController {
    
    @IBOutlet weak var keylbl: UILabel!
    @IBOutlet weak var passwordGeneratorBttn: UIButton!
    @IBOutlet weak var characterSetTextField: UITextField!
    @IBOutlet weak var CharacterSetButton: UIButton!
    @IBOutlet weak var passwordlenghtLabel: UILabel!
    @IBOutlet weak var passwordLenghtStepper: UIStepper!
    
    
    var newKey = generateKey()
            
    var configuration = PasswordsModel(passcodeLength: 4, characterSet: "!#%+23456789:=?@ABCDEFGHJKLMNPRSTUVWXYZabcdefghijkmnopqrstuvwxyz")

    override func viewDidLoad() {
        keylbl.text = stringKey(newKey)
        characterSetTextField.text = configuration.characterSet
        passwordLenghtStepper.maximumValue = 6
        passwordLenghtStepper.minimumValue = 1
        passwordLenghtStepper.autorepeat = false
        passwordLenghtStepper.wraps = false
        passwordLenghtStepper.value = 4
    }
    
    @IBAction func newKeyBtn(_ sender: UIButton) {
        newKey = generateKey()
        keylbl.text = stringKey(newKey)
    }
    
    @IBAction func createCards(_ sender: UIButton) {
        performSegue(withIdentifier: "PasswordSegue", sender: passwordGeneratorBttn)
    }
    
    @IBAction func resetCharacterSet(_ sender: UIButton) {
        characterSetTextField.text = configuration.characterSet
    }
    
    @IBAction func changePasswordLenght(_ sender: UIStepper) {
        configuration.passcodeLength = Int(sender.value)
        passwordlenghtLabel.text = String(configuration.passcodeLength)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier ==  "PasswordSegue"{
            let sendingKey = segue.destination as! CardsController
            sendingKey.mainKey = newKey
            let sendingCharacters = segue.destination as! CardsController
            sendingCharacters.characterSet = characterSetTextField.text
            let sendingPasswordLenght = segue.destination as! CardsController
            sendingPasswordLenght.passwordLenght = configuration.passcodeLength
        }
    }
    
}


